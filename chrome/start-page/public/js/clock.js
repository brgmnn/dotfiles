function get_month(date) {
  switch (date.getMonth()) {
    case 0:
      return 'january';
    case 1:
      return 'february';
    case 2:
      return 'march';
    case 3:
      return 'april';
    case 4:
      return 'may';
    case 5:
      return 'june';
    case 6:
      return 'july';
    case 7:
      return 'august';
    case 8:
      return 'september';
    case 9:
      return 'october';
    case 10:
      return 'november';
    case 11:
      return 'december';
  }
}

function get_ordinal(num) {
  num = num % 10;
  switch (num) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

function get_time(date) {
  var hours = date.getHours();
  var minutes = date.getMinutes();
  var ampm = hours < 12 ? 'am' : 'pm';
  hours = hours % 12;
  hours = hours == 0 ? 12 : hours;
  minutes = minutes < 10 ? '0'+minutes : minutes;
  return hours + '<span class="faded">:</span>' + minutes +
    '<span class="faded">' + ampm + '</span>';
}

function get_day(date) {
  switch (date.getDay()) {
    case 0:
      return 'sunday';
    case 1:
      return 'monday';
    case 2:
      return 'tuesday';
    case 3:
      return 'wednesday';
    case 4:
      return 'thursday';
    case 5:
      return 'friday';
    case 6:
      return 'saturday';
  }
}

function get_date(date) {
  return date.getDate() +
    "<sup>" + get_ordinal(date.getDate()) + "</sup> " +
    "<span class=\"faded\">" +
    get_month(date) + " " + date.getFullYear() + "</span>";
}

function update_time() {
  var now = new Date();
  document.getElementById('time').innerHTML = get_time(now);
  document.getElementById('day').innerHTML = get_day(now);
  document.getElementById('date').innerHTML = get_date(now);
}

document.addEventListener("DOMContentLoaded", function() {
  update_time();
  window.setInterval(update_time, 1000);
});
