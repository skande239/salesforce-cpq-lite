trigger SupportTicketTrigger on Support_Ticket__c (before insert) {

    for (Support_Ticket__c ticket : Trigger.new) {

        // Auto assign based on Category
        if (ticket.User__c == null) {

            if (ticket.Category__c == 'Technical') {
                ticket.User__c = UserInfo.getUserId();
                ticket.Status__c = 'In Progress';

            } else if (ticket.Category__c == 'Billing') {
                ticket.User__c = UserInfo.getUserId();
                ticket.Status__c = 'New';

            } else if (ticket.Category__c == 'General') {
                ticket.User__c = UserInfo.getUserId();
                ticket.Status__c = 'New';
            }
        }

        // Auto set priority based on category
        if (ticket.Priority__c == null) {
            if (ticket.Category__c == 'Technical') {
                ticket.Priority__c = 'High';
            } else if (ticket.Category__c == 'Billing') {
                ticket.Priority__c = 'Medium';
            } else {
                ticket.Priority__c = 'Low';
            }
        }
    }
}