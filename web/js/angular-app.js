var ng = angular.module('angularApp', []);

const MONTHS = [
    'ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.', 'มิ.ย.', 'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.'
];

ng.filter('url', () => input => WWW_ROOT + input);
ng.filter('fileSize', () => input => {
    if (input < 1024) return `${input.toFixed(2)} bytes`;
    input /= 1024;
    if (input < 1024) return `${input.toFixed(2)} KB`;
    input /= 1024;
    if (input < 1024) return `${input.toFixed(2)} MB`;
    input /= 1024;
    if (input < 1024) return `${input.toFixed(2)} GB`;
    input /= 1024;
    return `${input.toFixed(2)} TB`;
});
ng.filter('date', () => input => {
    const dateObj = new Date(input * 1000);
    const date = dateObj.getDate();
    const month = MONTHS[dateObj.getMonth()];
    const year = (dateObj.getFullYear() + 543) % 100;

    return `${date} ${month} ${year}`;
});
ng.filter('time', () => input => {
    const dateObj = new Date(input * 1000);
    let h = dateObj.getHours();
    h = h < 10 ? `0${h}` : h.toString();
    let m = dateObj.getMinutes();
    m = m < 10 ? `0${m}` : m.toString();

    return `${h}:${m}`;
});
ng.filter('stringPreview', () => input => {
    if (input.length > 100) {
        return `${input.substr(0, 100)}…`;
    }
    return input;
});
