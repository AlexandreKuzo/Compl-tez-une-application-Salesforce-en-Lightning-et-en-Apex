import { LightningElement, api, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getOpportunities from '@salesforce/apex/AccountOpportunitiesController.getOpportunities';

export default class AccountOpportunitiesViewer extends LightningElement {
    @api recordId;
    @track opportunities;
    @track error = {};
    wiredResult; // on stocke le résultat de la MAJ 

    columns = [
        { label: 'Nom Opportunité', fieldName: 'Name', type: 'text' },
        { label: 'Montant', fieldName: 'Amount', type: 'currency' },
        { label: 'Date de Clôture', fieldName: 'CloseDate', type: 'date' },
        { label: 'Phase', fieldName: 'StageName', type: 'text' }
    ];

    @wire(getOpportunities, { accountId: '$recordId' })
    wiredOpportunities(result) {
        this.wiredResult = result;
        if (result.data) {
            this.opportunities = result.data;
        } else if (result.error) {
            this.error = result.error;
            this.opportunities = undefined;
        }
    }
    
    handleRafraichir() {
        console.log('🔄 Rafraîchissement lancé');
        refreshApex(this.wiredResult)
            .then(() => console.log('✅ Rafraîchissement terminé'))
            .catch(error => console.error('❌ Erreur :', error));
        }



}