import { LightningElement } from 'lwc';

export default class AvaNota extends LightningElement {

    get options() {
        return [
            { label: '1', value: '1' },
            { label: '2', value: '2' },
            { label: '3', value: '3' },
            { label: '4', value: '4' },
            { label: '5', value: '5' },
        ]
    }

    handleChange(event){
        this.value = event.detail.value;
        
    }

    contactChangeVal(event) {
        const field = event.target.name;
        if (field) {
            this[field] = event.target.value;
        }
    }
}