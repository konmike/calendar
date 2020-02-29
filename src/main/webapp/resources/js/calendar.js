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

// -- setup

for(let m = 3; m < 15; m++) {
    const labels = $('#calendar label:nth-child(' + m + ') .month .labels');
    const dates = $('#calendar label:nth-child(' + m + ') .month .dates');
    //const month = $('#calendar label:nth-child(' + m + ')');
    // console.log(labels);
    // console.log(dates);

    //console.log(month);

    lspan = Array.from({length: 7}, () => {
        return labels.appendChild(h('span'));
    });
    //console.log(lspan);

    dspan = Array.from({length: 42}, () => {
        return dates.appendChild(h('span'));
    });
    //console.log(dspan);

    var month_h3 = document.createElement("h3");
    let firstChild = labels.firstChild;
    labels.insertBefore(month_h3,firstChild);
}

// -- state mgmt

const view = sublet({
    lang: 'cs',
    offset: 1,
    year: 2020,
    //month: 1,
}, update);

function update(state) {
    const offset = state.offset;

    const days = days_labels[state.lang];
    const months = months_labels[state.lang];

    let q = 0;
    for(let m = 3; m < 15; m++){
        const labels = $('#calendar label:nth-child(' + m + ') .month .labels');
        const dates = $('#calendar label:nth-child(' + m + ') .month .dates');
        const month_h3 = $('#calendar label:nth-child(' + m + ') .month .labels h3');
        // console.log(labels);
        // console.log(dates);

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

$('#lang').onchange = ev => {
    view.lang = ev.target.value;
};

$('#offset').onchange = ev => {
    view.offset = +ev.target.value;
};

$('#year').onchange = ev => {
    view.year = ev.target.value;
};