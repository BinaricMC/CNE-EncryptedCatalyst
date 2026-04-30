var vig = new CustomShader("coloredVignette");
var colorahs = new CustomShader('colorcorrection');

function postCreate() {
    snapCam();
}

function create(){
    for (i in [camGame]) {
        i.addShader(colorahs);
        i.addShader(vig);
    }
    vig.amount = 1;
    vig.strength = 1;


    colorahs.brightness = 0.0; 
    colorahs.contrast = 1.25; 
    colorahs.saturation = 1; 
    colorahs.customred = 0.3; 
    colorahs.customgreen = 0.0; 
    colorahs.customblue = 0.0; 
}

function beatHit(curBeat) {
    if (curBeat % 4 == 0) {
        switchColor1();
    }
}

function switchColor1(){

}