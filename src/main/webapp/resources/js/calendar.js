const $ = document.querySelector.bind(document);
const h = tag => document.createElement(tag);

const days_labels = {
    en: ['SUN','MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'],
    cs: ['NE', 'PO', 'ÚT', 'ST', 'ČT', 'PÁ', 'SO'],
};

const months_labels = {
    en: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
    cs: ['Leden', 'Únor', 'Březen', 'Duben', 'Květen', 'Červen', 'Červenec', 'Srpen', 'Září', 'Říjen', 'Listopad', 'Prosinec'],
};


let body = $("body");
var lang_d = body.getAttribute("data-custom-lang");
let offset_d = parseInt(body.getAttribute("data-custom-offset"),10);
let year_d = parseInt(body.getAttribute("data-custom-year"),10);
let type_d = parseInt(body.getAttribute("data-custom-type"),10);

if(lang_d === ""){
    lang_d = "cs";
    //console.log("lang set");
}
if(offset_d === 0){
    offset_d = 1;
    //console.log("offset set");
}
if(year_d === 0){
    year_d = 2020;
    //console.log("year set");
}
if(type_d === 0){
    type_d = 1;
    //console.log("type set");
}

let start = 3;
let end = 15;


if($('#calendar .pagination') == null){
    start = 2;
    end = 14;
}

if(type_d === 2 || type_d === 4){
    lspan_length = 42;
}

//console.log("Start: " + start);
//console.log("End: " + end);
// -- setup
function generateStructure (lspan_length, dspan_length, item){
    let labels = $('#calendar .label--item:nth-child(' + item + ') .month .labels');
    let dates = $('#calendar .label--item:nth-child(' + item + ') .month .dates');
    //const month = $('#calendar label.label--item:nth-child(1)');
    // console.log(labels);
    // console.log(dates);
    //console.log(month);

    if(labels === null){
        labels = $('#calendar .month:nth-child(' + item + ') .labels');
        dates = $('#calendar .month:nth-child(' + item + ') .dates');
    }

    //console.log(labels);
    //console.log(dates);

    //console.log(month);

    const lspan = Array.from({length: lspan_length}, () => {
        return labels.appendChild(h('span'));
    });
    //console.log(lspan);

    const dspan = Array.from({length: dspan_length}, () => {
        return dates.appendChild(h('span'));
    });
    //console.log(dspan);

    var month_h3 = document.createElement("h3");
    let firstChild = labels.firstChild;
    labels.insertBefore(month_h3,firstChild);

}

// -- state mgmt

function daysInMonth (month, year) { // Use 1 for January, 2 for February, etc.
    return new Date(year, month, 0).getDate();
}

const view = sublet({
    lang: lang_d,
    offset: offset_d,
    year: year_d,
    type: type_d,
}, update);

function update(state) {
    const offset = state.offset;

    const days = days_labels[state.lang];
    const months = months_labels[state.lang];

    if(type_d === 2 || type_d === 4){
        let item = 3;

        for( let i = 0; i < 11; i++){
            let numberDays = daysInMonth(i,year_d);
            console.log("Pocet dni v " + i);
            const firstDayInMonthIndex = (
                monthIndex = i,
                year = year_d
            ) => (
                new Date(`${year}-${monthIndex + 1}-01`).getDay()
            );
            console.log("Prvni den v mesici " + i + " je " + firstDayInMonthIndex);

            generateStructure(numberDays,numberDays, item, firstDayInMonthIndex);
            item++;
        }

        return true;
    }

    //console.log("update");
    //console.log(offset);
    //console.log(lang_d);


    // console.log(offset);
    //
    //
    // console.log(days[(0 + offset) % 7]);
    // console.log(offset);
    // console.log(days);
    // console.log(days[(1 + offset) % 7]);
    // console.log(offset);
    // console.log(days);
    // console.log(days[(2 + offset) % 7]);
    // console.log(offset);
    // console.log(days);
    // console.log(days[(3 + offset) % 7]);
    // console.log(days[(4 + offset) % 7]);
    // console.log(days[(5 + offset) % 7]);
    // console.log(days[(6 + offset) % 7]);
    let lspan_length = 7;
    let dspan_length = 42;
    generateStructure(7,42);
    let q = 0;
    for(let m = start; m < end; m++){
        let labels = $('#calendar .label--item:nth-child(' + m + ') .month .labels');
        let dates = $('#calendar label:nth-child(' + m + ') .month .dates');
        let month_h3 = $('#calendar label:nth-child(' + m + ') .month .labels h3');
        // console.log(labels);
        // console.log(dates);

        if(labels === null){
            labels = $('#calendar .month:nth-child(' + m + ') .labels');
            dates = $('#calendar .month:nth-child(' + m + ') .dates');
            month_h3 = $('#calendar .month:nth-child(' + m + ') .labels h3');
        }

        const lspan = [].slice.call(labels.getElementsByTagName('span'));
        console.log(lspan);

        const dspan = [].slice.call(dates.getElementsByTagName('span'));
        //console.log(dspan);

        month_h3.textContent = months[q];

        lspan.forEach((el, idx) => {
            console.log("Offset: " + offset);
            console.log("Index: " + idx);
            var tmp = idx+offset;
            console.log("Tmp: " + tmp);
            var tmp2 = tmp%7;
            console.log("Tmp2: " + tmp2);
            console.log("Vysledek cislo: " + ((idx+offset)%7));
            console.log(el);
            console.log("Vysledek den: " + days[(idx + offset)%7]);
            el.textContent = days[(idx + offset) % 7];
        });


        let i=0, j=0, date = new Date(state.year, q);
        //console.log(new Date(state.year,q));

        calendarize(date, offset).forEach(week => {
            for (j=0; j < 7; j++) {
                dspan[i++].textContent = week[j] > 0 ? week[j] : '';
            }
        });
        q++;

        // clear remaining (very naiive way, pt 2)
        while (i < dspan.length) dspan[i++].textContent = '';
    }
}

// -- inputs

if($('#lang'))
$('#lang').onchange = ev => {
    view.lang = ev.target.value;
};
if($('#offset'))
$('#offset').onchange = ev => {
    view.offset = +ev.target.value;
};
if($('#year'))
$('#year').onchange = ev => {
    view.year = ev.target.value;
};
if($('#type'))
    $('#type').onchange = ev => {
        view.type = ev.target.value;
    };
