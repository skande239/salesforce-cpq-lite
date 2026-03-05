public with sharing class QuoteEmailSender {

    public static void sendQuotePDF(Id quoteId) {

        // Get quote details
        Quote__c quote = [
            SELECT Id, Name, Status__c, Total_Amount__c,
                   Opportunity__r.Account.Name
            FROM Quote__c
            WHERE Id = :quoteId
            LIMIT 1
        ];

        // Generate the PDF from the Visualforce page
        PageReference pdfPage = Page.QuotePDF;
        pdfPage.getParameters().put('id', quoteId);
        Blob pdfBlob;

        // In test context, use a dummy blob
        if (Test.isRunningTest()) {
            pdfBlob = Blob.valueOf('PDF Content');
        } else {
            pdfBlob = pdfPage.getContentAsPDF();
        }

        // Build the email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        email.setSubject('Quote: ' + quote.Name + ' - ' + quote.Total_Amount__c);
        email.setToAddresses(new List<String>{ UserInfo.getUserEmail() });
        email.setPlainTextBody(
            'Please find attached the quote: ' + quote.Name +
            '\nStatus: ' + quote.Status__c +
            '\nTotal Amount: $' + quote.Total_Amount__c
        );

        // Attach the PDF
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName(quote.Name + '.pdf');
        attachment.setBody(pdfBlob);
        attachment.setContentType('application/pdf');

        email.setFileAttachments(new List<Messaging.EmailFileAttachment>{ attachment });

        // Send it
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ email });
    }
}
