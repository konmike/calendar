const $ = document.querySelector.bind(document);
const h = tag => document.createElement(tag);

const days_labels = {
    en: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'],
    cs: ['NE', 'PO', 'ÚT', 'ST', 'ČT', 'PÁ', 'SO'],
};

const months_labels = {
    en: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
    cs: ['Leden', 'Únor', 'Březen', 'Duben', 'Květen', 'Červen', 'Červenec', 'Srpen', 'Září', 'Říjen', 'Listopad', 'Prosinec'],
};

var start = 3;
var end = 15;
if($('#calendar .pagination') == null){
    start = 2;
    end = 14;
}

//console.log("Start: " + start);
//console.log("End: " + end);
// -- setup

for(let m = start; m < end; m++) {
    let labels = $('#calendar .label--item:nth-child(' + m + ') .month .labels');
    let dates = $('#calendar .label--item:nth-child(' + m + ') .month .dates');
    //const month = $('#calendar label.label--item:nth-child(1)');
    // console.log(labels);
    // console.log(dates);
    //console.log(month);

    if(labels === null){
        labels = $('#calendar .month:nth-child(' + m + ') .labels');
        dates = $('#calendar .month:nth-child(' + m + ') .dates');
    }

    //console.log(labels);
    //console.log(dates);

    //console.log(month);

    const lspan = Array.from({length: 7}, () => {
        return labels.appendChild(h('span'));
    });
    //console.log(lspan);

    const dspan = Array.from({length: 42}, () => {
        return dates.appendChild(h('span'));
    });
    //console.log(dspan);

    var month_h3 = document.createElement("h3");
    let firstChild = labels.firstChild;
    labels.insertBefore(month_h3,firstChild);
}

// -- state mgmt

var lang_d = $("body").getAttribute("data-custom-lang");
var offset_d = $("body").getAttribute("data-custom-offset");
var year_d = $("body").getAttribute("data-custom-year");

if(lang_d === ""){
    lang_d = "cs";
    //console.log("lang set");
}
if(offset_d === "0"){
    offset_d = 1;
    //console.log("offset set");
}
if(year_d === "0"){
    year_d = 2020;
    //console.log("year set");
}


const view = sublet({
    lang: lang_d,
    offset: offset_d,
    year: year_d,
    //month: 1,
}, update);

function update(state) {
    const offset = state.offset;

    const days = days_labels[state.lang];
    const months = months_labels[state.lang];


    console.log(offset);


    console.log(days[(0 + offset) % 7]);
    console.log(offset);
    console.log(days);
    console.log(days[(1 + offset) % 7]);
    console.log(offset);
    console.log(days);
    console.log(days[(2 + offset) % 7]);
    console.log(offset);
    console.log(days);
    console.log(days[(3 + offset) % 7]);
    console.log(days[(4 + offset) % 7]);
    console.log(days[(5 + offset) % 7]);
    console.log(days[(6 + offset) % 7]);


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
        // console.log(lspan);

        const dspan = [].slice.call(dates.getElementsByTagName('span'));
        //console.log(dspan);

        month_h3.textContent = months[q];

        lspan.forEach((el, idx) => {
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