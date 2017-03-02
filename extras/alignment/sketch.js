// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Seeking "vehicle" follows the mouse position

// Implements Craig Reynold's autonomous steering behaviors
// One vehicle "seeks"
// See: http://www.red3d.com/cwr/

var vehicles = [];

function setup() {
    createCanvas(800, 600);
    for (var i = 0; i < 50; i++) {
        vehicles[i] = new Vehicle(random(width), random(height));
    }
}

function draw() {
    background(51);

    var mouse = createVector(mouseX, mouseY);

    // Call the appropriate steering behaviors for our agents
    for (var i = 0; i < vehicles.length; i++) {
        var v = vehicles[i];
        //v.seek(mouse);
        v.alignment();
        v.update();
        v.display();
        v.borders();
    }

}
