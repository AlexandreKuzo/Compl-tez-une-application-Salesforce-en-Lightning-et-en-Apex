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
        String searchTerm = 'Test'
        Test.startTest();
        List<Cases> results = AccountCaseController.findCasesBySubject(testAccount.Id, searchTerm)
        Test.stopTest();
        Assert.areEqual(2, results.size(), 'Should return one or more case.')
    }
}