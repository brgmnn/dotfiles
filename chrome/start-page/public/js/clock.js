function get_time(date) {
  //4<span class="faded">:</span>41<span class="faded">pm</span>
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
  return date.getDate();
}

function update_time() {
  var now = new Date();
  document.getElementById('day').innerHTML = get_day(now);
  document.getElementById('date').innerHTML = get_date(now);
}

document.addEventListener("DOMContentLoaded", function() {
  update_time();
});
