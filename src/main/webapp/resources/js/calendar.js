const $ = document.querySelector.bind(document);
const h = tag => document.createElement(tag);

const text_labels = {
    en: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'],
    cs: ['NE', 'PO', 'ÚT', 'ST', 'ČT', 'PÁ', 'SO'],
};

// -- setup

var lspan = null;
var dspan = null;

//const month = $('.month:first-child');

//month.classList.add("cusik");
//console.log(labels);
//console.log(dates);


// -- state mgmt

const view = sublet({
    lang: 'en',
    offset: 1,
    year: 2020,
    //month: 1,
}, update);

function update(state) {
    const offset = state.offset;

    // apply day labels
    const txts = text_labels[state.lang];

    let q = 0;
    for(let m = 2; m < 14; m++){
        const labels = $('#calendar label:nth-child(' + m + ') .month .labels');
        const dates = $('#calendar label:nth-child(' + m + ') .month .dates');
        const month = $('#calendar label:nth-child(' + m + ') .month');
        //const month = $('#calendar label:nth-child(4) .month');
        console.log(labels);
        console.log(dates);
        month.classList.add("cusik");

        lspan = Array.from({ length: 7 }, () => {
            return labels.appendChild(h('span'));
        });

        dspan = Array.from({ length: 42 }, () => {
            return dates.appendChild(h('span'));
        });

        lspan.forEach((el, idx) => {
            el.textContent = txts[(idx + offset) % 7];
        });


        let i=0, j=0, date = new Date(state.year, q);
        calendarize(date, offset).forEach(week => {
            for (j=0; j < 7; j++) {
                dspan[i++].textContent = week[j] > 0 ? week[j] : '';
            }
        });
        q++;
        // clear remaining (very naiive way, pt 2)
        while (i < dspan.length) dspan[i++].textContent = '';
    }


    console.log(new Date(2020,0));
    // apply date labels (very naiive way, pt 1)



}

// -- inputs

$('#lang').onchange = ev => {
    view.lang = ev.target.value;
};

$('#offset').onchange = ev => {
    view.offset = +ev.target.value;
};

/*$('#month').onchange = ev => {
  view.month = ev.target.value;
};*/

$('#year').onchange = ev => {
    view.year = ev.target.value;
};