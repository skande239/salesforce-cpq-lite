public with sharing class QuoteCalculator {

    // Calculate all line item totals + quote totals
    public static void calculateQuoteTotals(List<Id> quoteIds) {
        
        // Get all quotes with their line items
        List<Quote__c> quotesToUpdate = [
            SELECT Id, Discount__c, Tax__c,
                (SELECT Quantity__c, Unit_Price__c, Line_Total__c 
                 FROM Quote_Line_Items__r)
            FROM Quote__c
            WHERE Id IN :quoteIds
        ];

        List<Quote_Line_Item__c> lineItemsToUpdate = new List<Quote_Line_Item__c>();

        for (Quote__c quote : quotesToUpdate) {
            
            Decimal subtotal = 0;

            // Step 1: Calculate each line total
            for (Quote_Line_Item__c item : quote.Quote_Line_Items__r) {
                
                Decimal lineTotal = (item.Quantity__c != null && item.Unit_Price__c != null)
                    ? item.Quantity__c * item.Unit_Price__c
                    : 0;

                item.Line_Total__c = lineTotal;
                subtotal += lineTotal;
                lineItemsToUpdate.add(item);
            }

            // Step 2: Calculate discount, tax, total on the quote
            Decimal discountRate = quote.Discount__c != null ? quote.Discount__c / 100 : 0;
            Decimal taxRate      = quote.Tax__c != null ? quote.Tax__c / 100 : 0;

            Decimal discountAmount = subtotal * discountRate;
            Decimal taxAmount      = (subtotal - discountAmount) * taxRate;

            quote.Subtotal__c      = subtotal;
            quote.Total_Amount__c  = subtotal - discountAmount + taxAmount;
        }

        // Step 3: Save everything
        if (!lineItemsToUpdate.isEmpty()) update lineItemsToUpdate;
        if (!quotesToUpdate.isEmpty())    update quotesToUpdate;
    }
}