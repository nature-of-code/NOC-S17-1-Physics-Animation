// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// The "Vehicle" class

function Vehicle(x, y) {
    this.maxspeed = 4;
    this.maxforce = 0.1;
    this.acceleration = createVector(0, 0);
    this.velocity = p5.Vector.random2D();
    this.velocity.setMag(this.maxspeed);
    this.position = createVector(x, y);
    this.r = 4;

    // Method to update location
    this.update = function() {
        // Update velocity
        this.velocity.add(this.acceleration);
        // Limit speed
        this.velocity.limit(this.maxspeed);
        this.position.add(this.velocity);
        // Reset accelerationelertion to 0 each cycle
        this.acceleration.mult(0);
    };

    this.applyForce = function(force) {
        // We could add mass here if we want A = F / M
        this.acceleration.add(force);
    };

    this.alignment = function() {
        var threshold = 100;
        var count = 0;

        var desired = createVector(0, 0);
        for (var i = 0; i < vehicles.length; i++) {
            var v = vehicles[i];
            var d = dist(v.position.x, v.position.y, this.position.x, this.position.y);
            if (v != this && d < threshold) {
                desired.add(v.velocity);
                count++;
            }
        }

        if (count > 0) {
            desired.div(count);
            desired.setMag(this.maxspeed);
            // Reynolds Steering Rule
            var steer = p5.Vector.sub(desired, this.velocity);
            steer.limit(this.maxforce); // Limit to maximum steering force
            this.applyForce(steer);
        }



    }

    // Wraparound
    this.borders = function() {
        if (this.position.x < -this.r) this.position.x = width + this.r;
        if (this.position.y < -this.r) this.position.y = height + this.r;
        if (this.position.x > width + this.r) this.position.x = -this.r;
        if (this.position.y > height + this.r) this.position.y = -this.r;
    };



    // A method that calculates a steering force towards a target
    // STEER = DESIRED MINUS VELOCITY
    this.seek = function(target) {

        var desired = p5.Vector.sub(target, this.position); // A vector pointing from the location to the target

        // Scale to maximum speed
        desired.setMag(this.maxspeed);

        // Steering = Desired minus velocity
        var steer = p5.Vector.sub(desired, this.velocity);
        steer.limit(this.maxforce); // Limit to maximum steering force

        this.applyForce(steer);
    };

    this.display = function() {
        // Draw a triangle rotated in the direction of velocity
        var theta = this.velocity.heading() + PI / 2;
        fill(127);
        stroke(200);
        strokeWeight(1);
        push();
        translate(this.position.x, this.position.y);
        rotate(theta);
        beginShape();
        vertex(0, -this.r * 2);
        vertex(-this.r, this.r * 2);
        vertex(this.r, this.r * 2);
        endShape(CLOSE);
        pop();
    };
}
