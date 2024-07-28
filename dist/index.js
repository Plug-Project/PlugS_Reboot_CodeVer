
const secondsToMinutesAndSeconds = (seconds) => {
    var minutes = Math.floor(seconds / 60);
    var remainingSeconds = seconds % 60;
    return minutes + ":" + (remainingSeconds < 10 ? "0" : "") + remainingSeconds;
}

const SetTimer = (time) => {
    const formattedTime = secondsToMinutesAndSeconds(time)
    $(".timer").text(formattedTime)
}

const ToggleTimer = (status) => {
    if (status) {
        $(".app").fadeIn(500);
    }else{
        $(".app").fadeOut(500);
    }
}

window.addEventListener('message', function(event) {
    if (event.data.type == "toggle") {
        ToggleTimer(event.data.status);
    } 
    if (event.data.type == "timer") {
        SetTimer(event.data.time)
    } 
});