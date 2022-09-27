@isTest
public class HelloWorld_TEST {
    public static TestMethod void sayHello() {
        System.assert(TRUE, 'We will never see this assert-failed message.');
    }
}