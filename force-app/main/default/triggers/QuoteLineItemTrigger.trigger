trigger QuoteLineItemTrigger on Quote_Line_Item__c (
    after insert, after update, after delete
) {
    Set<Id> quoteIds = new Set<Id>();

    // Collect Quote IDs from inserted or updated line items
    if (Trigger.isInsert || Trigger.isUpdate) {
        for (Quote_Line_Item__c item : Trigger.new) {
            if (item.Quote__c != null) {
                quoteIds.add(item.Quote__c);
            }
        }
    }

    // Collect Quote IDs from deleted line items
    if (Trigger.isDelete) {
        for (Quote_Line_Item__c item : Trigger.old) {
            if (item.Quote__c != null) {
                quoteIds.add(item.Quote__c);
            }
        }
    }

    // Call the calculator
    if (!quoteIds.isEmpty()) {
        QuoteCalculator.calculateQuoteTotals(new List<Id>(quoteIds));
    }
}