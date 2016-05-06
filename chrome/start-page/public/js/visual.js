var gl = null;
var canvas;

var Particles = {
  position: [],
  velocity: [],

  buffer: null,
  shader: null,

  SIZE: 50000,
  FPS: 60,

  // Percent of total viewport.
  MAX_SPEED: 0.1,

  init: function() {
    for (var i=0; i<this.SIZE; i++) {
      // Initialise the particle positions
      this.position.push(Math.random() - 0.5); // pos x
      this.position.push(Math.random() - 0.5); // pos y
      this.position.push(0.0);

      // Initialise the particle velocities
      this.velocity.push(this.MAX_SPEED*(Math.random() - 0.5)/(this.FPS)); // vel x
      this.velocity.push(this.MAX_SPEED*(Math.random() - 0.5)/(this.FPS)); // vel y
    }

    this.create_buffer();
    this.create_shader();
  },

  create_buffer: function() {
    this.buffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, this.buffer);
  },

  create_shader: function() {
    // vertex shader source code
    var vertCode =
      'attribute vec3 coordinates;' +
      'void main(void) {' +
      '  gl_Position = vec4(coordinates, 1.0);' +
      '  gl_PointSize = 1.0;'+
      '}';

    // Create a vertex shader object
    // Attach vertex shader source code
    // Compile the vertex shader
    var vertShader = gl.createShader(gl.VERTEX_SHADER);
    gl.shaderSource(vertShader, vertCode);
    gl.compileShader(vertShader);

    // fragment shader source code
    var fragCode =
      'void main(void) {' +
      ' gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);' +
      '}';

    // Create fragment shader object
    // Attach fragment shader source code
    // Compile the fragmentt shader
    var fragShader = gl.createShader(gl.FRAGMENT_SHADER);
    gl.shaderSource(fragShader, fragCode);
    gl.compileShader(fragShader);

    // Create a shader program object to store
    // the combined shader program
    this.shader = gl.createProgram();

    // Attach a vertex shader
    // Attach a fragment shader
    // Link both programs
    // Use the combined shader program object
    gl.attachShader(this.shader, vertShader);
    gl.attachShader(this.shader, fragShader);
    gl.linkProgram(this.shader);
    gl.useProgram(this.shader);

    var coord = gl.getAttribLocation(Particles.shader, "coordinates");
    gl.vertexAttribPointer(coord, 3, gl.FLOAT, false, 0, 0);
    gl.enableVertexAttribArray(coord);
  },

  iterate: function() {
    for (var i=0; i<this.SIZE; i++) {
      var x = this.position[3*i  ];
      var y = this.position[3*i+1];

      // gravity velocity adjustment
      this.velocity[2*i  ] -= 0.0001 * x / ( (x*x + y*y) * this.FPS);
      this.velocity[2*i+1] -= 0.0001 * y / ( (x*x + y*y) * this.FPS);

      // move particle
      x = this.position[3*i  ] + this.velocity[2*i  ];
      y = this.position[3*i+1] + this.velocity[2*i+1];

      // bound checking for x
      if (x < -1.0 || x > 1.0) {
        this.velocity[2*i] *= -0.2;
      } else {
        this.position[3*i  ] = x;
      }

      // bound checking for y
      if (y < -1.0 || y > 1.0) {
        this.velocity[2*i+1] *= -0.2;
      } else {
        this.position[3*i+1] = y;
      }
    }
  }
}


function initWebGL(canvas) {
  gl = null;

  try {
    // Try to grab the standard context. If it fails, fallback to experimental.
    gl = canvas.getContext("webgl") || canvas.getContext("experimental-webgl");
  }
  catch(e) {}

  // If we don't have a GL context, give up now
  if (!gl) {
    alert("Unable to initialize WebGL. Your browser may not support it.");
    gl = null;
  }

  return gl;
}

function render() {
  Particles.iterate();

  gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(Particles.position), gl.STATIC_DRAW);

  /*============= Drawing the primitive ===============*/
  // Clear the canvas
  // Enable the depth test
  // Clear the color buffer bit
  //gl.clearColor(0.0, 0.0, 0.0, 0.0);
  //gl.enable(gl.DEPTH_TEST);
  //gl.clear(gl.COLOR_BUFFER_BIT);

  canvas.width = canvas.clientWidth;
  canvas.height = canvas.clientHeight;

  // Set the view port
  gl.viewport(0, 0, gl.drawingBufferWidth, gl.drawingBufferHeight);

  // Draw the triangle
  gl.drawArrays(gl.POINTS, 0, Particles.SIZE);
}



document.addEventListener('DOMContentLoaded', function() {
  canvas = document.getElementById("glcanvas");

  // Initialize the GL context
  gl = initWebGL(canvas);

  // Only continue if WebGL is available and working
  if (!gl) {
    return;
  }

  Particles.init();

  window.setInterval(render, 1000/Particles.FPS);



//  // Set clear color to black, fully opaque
//  gl.clearColor(0.0, 0.0, 0.0, 0.0);
//  // Enable depth testing
//  gl.enable(gl.DEPTH_TEST);
//  // Near things obscure far things
//  gl.depthFunc(gl.LEQUAL);
//  // Clear the color as well as the depth buffer.
//  gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
//

//  gl.viewport(0, 0, canvas.width, canvas.height);
//  debugger;
});
