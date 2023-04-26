const urlParamsContractsReportPage = new URLSearchParams(window.location.search);
const inputStart = urlParamsContractsReportPage.get('inputStart');
const inputEnd = urlParamsContractsReportPage.get('inputEnd');

const startPeriod = urlParamsContractsReportPage.get('startPeriod');
const endPeriod = urlParamsContractsReportPage.get('endPeriod');

if (inputStart != null && inputEnd != null) {
    document.getElementById('inputStart').value = inputStart;
    document.getElementById('inputEnd').value = inputEnd;
}

if (startPeriod != null && endPeriod != null) {
    document.getElementById('startPeriod').value = startPeriod;
    document.getElementById('endPeriod').value = endPeriod;
}