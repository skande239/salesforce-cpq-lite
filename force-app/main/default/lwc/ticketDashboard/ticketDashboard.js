import { LightningElement, wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi';
import TICKET_OBJECT from '@salesforce/schema/Support_Ticket__c';

export default class TicketDashboard extends LightningElement {

    @wire(getListUi, {
        objectApiName: TICKET_OBJECT,
        listViewApiName: 'All'
    })
    tickets;

    get totalTickets() {
        return this.tickets.data ? this.tickets.data.records.records.length : 0;
    }

    get openTickets() {
        return this.tickets.data
            ? this.tickets.data.records.records.filter(t => t.fields.Status__c.value === 'New' || t.fields.Status__c.value === 'In Progress').length
            : 0;
    }

    get escalatedTickets() {
        return this.tickets.data
            ? this.tickets.data.records.records.filter(t => t.fields.Status__c.value === 'Escalated').length
            : 0;
    }

    get closedTickets() {
        return this.tickets.data
            ? this.tickets.data.records.records.filter(t => t.fields.Status__c.value === 'Closed').length
            : 0;
    }
}