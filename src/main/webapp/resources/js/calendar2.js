const $ = document.querySelector.bind(document);
const h = tag => document.createElement(tag);

const days_labels = {
    cs: ['PO', 'ÚT', 'ST', 'ČT', 'PÁ', 'SO', 'NE']
};

const months_labels = {
    cs: ['Leden', 'Únor', 'Březen', 'Duben', 'Květen', 'Červen', 'Červenec', 'Srpen', 'Září', 'Říjen', 'Listopad', 'Prosinec']
};

// const days_labels = {
//     en: ['SUN','MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'],
//     cs: ['NE', 'PO', 'ÚT', 'ST', 'ČT', 'PÁ', 'SO'],
// };

// const months_labels = {
//     en: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
//     cs: ['Leden', 'Únor', 'Březen', 'Duben', 'Květen', 'Červen', 'Červenec', 'Srpen', 'Září', 'Říjen', 'Listopad', 'Prosinec'],
// };

const numbers = ['1','2','3','4','5','6','7','8','9',
                '10','11','12','13','14','15','16','17','18','19',
                '20','21','22','23','24','25','26','27','28','29', '30', '31'];

let body = $("body");
//let lang_d = body.getAttribute("data-custom-lang");
//let offset_d = parseInt(body.getAttribute("data-custom-offset"),10);
let year_d = parseInt(body.getAttribute("data-custom-year"),10);
let type_d = parseInt(body.getAttribute("data-custom-type"),10);

/*if(lang_d === ""){
    lang_d = "cs";
    //console.log("lang set");
}
if(offset_d === 0){
    offset_d = 1;
    //console.log("offset set");
}*/
if(year_d === 0){
    year_d = 2020;
    //console.log("year set");
}
if(type_d === 0){
    type_d = 1;
    //console.log("type set");
}

const view = sublet({
    //lang: lang_d,
    //offset: offset_d,
    year: year_d,
    type: type_d,
}, update);

function daysInMonth (month, year) { // Use 1 for January, 2 for February, etc.
    return new Date(year, month, 0).getDate();
}

function generateStructureAndFill (lspan_length, dspan_length, firstDay, item, month, state, type, monthDayCount){
    const days = days_labels["cs"];
    const months = months_labels["cs"];

    let labels = $('#calendar .label--item:nth-child(' + item + ') .month .labels');
    let dates = $('#calendar .label--item:nth-child(' + item + ') .month .dates');
    let wrapper_dates = $('#calendar .label--item:nth-child(' + item + ') .month .wrapper-dates');

    if(labels === null){
        labels = $('#calendar .month:nth-child(' + item + ') .labels');
        dates = $('#calendar .month:nth-child(' + item + ') .dates');
        wrapper_dates = $('#calendar .month:nth-child(' + item + ') .wrapper-dates');
    }

    if(type === 2 || type === 4){
        labels.setAttribute("style", "grid-template-columns: repeat(" + lspan_length +", 1fr)");
        dates.setAttribute("style", "grid-template-columns: repeat(" + dspan_length +", 1fr)");
    }else{
        labels.removeAttribute("style");
        dates.removeAttribute("style");
    }


    Array.from({length: lspan_length}, () => {
        return labels.appendChild(h('span'));
    });
    //console.log(lspan);

    let month_h3 = document.createElement("h3");
    let firstChild = wrapper_dates.firstChild;
    wrapper_dates.insertBefore(month_h3,firstChild);
    //labels.insertBefore(month_h3,firstChild);


    //vloz nazev mesice
    month_h3.textContent = months[month];

    //vloz dny v tydnu
    const lspan = [].slice.call(labels.getElementsByTagName('span'));

    if(type === 2 || type === 4) {
        lspan.forEach((el, idx) => {
            el.textContent = days[(idx + firstDay - 1) % 7];
        });
        Array.from({length: dspan_length}, () => {
            return dates.appendChild(h('span'));
        });

        const dspan = [].slice.call(dates.getElementsByTagName('span'));

        for(let q = 0; q < dspan_length; q++){
            dspan[q].textContent = numbers[q];
        }
    }
    else {
        lspan.forEach((el, idx) => {
            el.textContent = days[idx];
        });

        Array.from({length: dspan_length}, () => {
            return dates.appendChild(h('span'));
        });

        const dspan = [].slice.call(dates.getElementsByTagName('span'));

        let n = 0;
        for(let q = (firstDay-1); q < (monthDayCount + firstDay - 1); q++){
            dspan[q].textContent = numbers[n];
            n++;
        }
    }
}

function update(state) {
    //const offset = state.offset;
    const type = parseInt(state.type);

    let wrapper_dates = document.getElementsByClassName("wrapper-dates");
    let labels = document.getElementsByClassName("labels");
    let dates = document.getElementsByClassName("dates");
    for (let i = 0; i < labels.length; i++) {
        labels[i].innerHTML = "";
        dates[i].innerHTML = "";

        if(document.getElementsByTagName("h3")){
            wrapper_dates[i].removeChild(wrapper_dates[i].childNodes[0]);
        }
    }


    console.log("State type " + type);

    if(type === 2 || type === 4){
        let item = 2;
        let month = 0;

        for( let i = 1; i < 13; i++){
            let numberDays = daysInMonth(i,state.year);
            //console.log("Pocet dni v " + i + " je " + numberDays);
            let day = new Date(state.year + "-" + i + "-01").getDay();
            if(day === 0)
                day = 7;
            //console.log("Prvni den v mesici " + i + " je " + day);

            generateStructureAndFill(numberDays,numberDays, day, item, month, state, type, numberDays);
            item++;
            month++;
            console.log("Increment " + item);
        }
    }else{
        let item = 2;
        let month = 0;
        for( let i = 1; i < 13; i++) {
            let numberDays = daysInMonth(i,state.year);
            let day = new Date(state.year + "-" + i + "-01").getDay();
            if(day === 0)
                day = 7;
            generateStructureAndFill(7, 42, day, item, month, state, type, numberDays);
            item++;
            month++;
        }
    }

}

// let lang = $('#lang');
// let offset = $('#offset');
let year = $('#year');
let type = $('#type');
// if(lang)
//     lang.onchange = ev => {
//         view.lang = ev.target.value;
//     };
// if(offset)
//     offset.onchange = ev => {
//         view.offset = ev.target.value;
//     };
if(year)
    year.onchange = ev => {
        view.year = ev.target.value;
    };
if(type)
    type.onchange = ev => {
        view.type = ev.target.value;
    };