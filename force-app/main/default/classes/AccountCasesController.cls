public with sharing class AccountCasesController {

    @AuraEnabled

    public static List<Case> findCasesBySubject(Id accountId, String subjectSearchTerm){
        if (accountId == null) {
            throw new AuraHandledException('The account ID is required.');
        }

        List<Case> cases = [
            SELECT Id, Subject, Status, Priority
            FROM Case
            WHERE AccountId = :accountId
            AND Subject LIKE :('%' + subjectSearchTerm + '%')
            LIMIT 10
        ];

        return cases;
    }

}