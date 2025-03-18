/**
@author AlexandreKuzo
 */
@isTest
private class AccountCaseControllerTest {

    @TestSetup
    static void setup() {
        Account testAccount = TestDataFactory.createTestAccount();
        insert testAccount;

        List<Case> testCases = new List<Case>{
            new Case(AccountId = testAccount.Id, Subject = 'Test Case 1', Status = 'New', Priority = 'Medium'),
            new Case(AccountId = testAccount.Id, Subject = 'Test Case 2', Status = 'New', Priority = 'High')
        };
        insert testCases;
    }

    @IsTest
    static void testFindCasesBySubject() {
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        String searchTerm = 'Test';
        Test.startTest();
        List<Case> results = AccountCasesController.findCasesBySubject(testAccount.Id, searchTerm);
        Test.stopTest();
        Assert.areEqual(2, results.size(), 'Should return one or more case.');
    }

    @IsTest
    static void testFindCasesBySubjectWithNoAccountId() {
        try {
            AccountCasesController.findCasesBySubject(null, 'Test');
            System.assert(false, 'Expected AuraHandledException was not thrown.');
        } catch (AuraHandledException e) {
            System.assertEquals('L\'ID du compte est requis.', e.getMessage());
        }
    }
}