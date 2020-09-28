import { LightningElement, wire } from 'lwc';
import fetchDataFromGithub from '@salesforce/apex/strategicFinancialSolutions.fetchDataFromGithub';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const columns = [
    { label: 'Creditor', fieldName: 'creditorName', type: 'string' },
    { label: 'First Name', fieldName: 'firstName', type: 'string' },
    { label: 'Last Name', fieldName: 'lastName', type: 'string' },
    { label: 'Min Pay%', fieldName: 'minPaymentPercentage', type: 'decimal' },
    { label: 'Balance', fieldName: 'balance', type: 'currency' },
];

export default class StrategicFinancialSolutions extends LightningElement {
    json_response = [];
    columns = columns;
    selectedtotal;
    initialtotal;
    totaltodisplay;
    totalrows;
    selectedrows;
    new_rows = [];

    @wire(fetchDataFromGithub)
    githubContent({ data, error }) {
        if (data) {

            this.json_response = data;
            this.calculateTotals();
            this.error = undefined;
        }
        else if (error) {
            this.error = error;

        }
    }

    addItemsToTable(event) {
        this.json_response = [
            ...this.json_response,
            {
                'id': 11,
                'creditorName': 'NAVY FCU',
                'firstName': '',
                'lastName': '',
                'minPaymentPercentage': 2.00,
                'balance': 2763.00
            }
        ];
        this.dispatchEvent(new ShowToastEvent({
            title: 'Notification - Item Added',
            message: 'New Row Added',
            variant: 'success'
        }));
        this.calculateTotals();
    }

    removeItemsToTable(event) {
        this.json_response.pop();
        this.json_response = [...this.json_response];
        this.calculateTotals();
        this.dispatchEvent(new ShowToastEvent({
            title: 'Notification - Item Removed',
            message: 'Row Removed',
            variant: 'info'
        }));
    }

    calculateTotals() {
        // utility to calculate totals 
        this.initialtotal = this.json_response.reduce(function (prev, cur) {
            return prev + cur.balance;
        }, 0);
        this.totalrows = this.json_response.length;
        if (this.selectedtotal > 0) {
            this.totaltodisplay = this.selectedtotal;
        }
        else {
            this.totaltodisplay = this.initialtotal;
        }
        var ldtable = this.template.querySelector('lightning-datatable');
        this.selectedRows = ldtable.getSelectedRows().length;
    }

    handleRowClicks(event) {
        this.new_rows = event.detail.selectedRows;
        this.selectedtotal = this.new_rows.reduce(function (prev, cur) {
            return prev + cur.balance;
        }, 0);
        this.calculateTotals();
    }

    handleHeaderActions(event) {
        this.calculateTotals();
    }
}