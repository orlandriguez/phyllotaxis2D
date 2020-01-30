size(600, 800);
background(255);
//stroke(46,125,50);

// INPUT PARAMETERS
//float beta = radians(145.f);          // Parastichy Slope
//float gamma = radians(46.5f);         // Transversal floral slope
float beta = radians(35.f);           // Parastichy Slope
float gamma = radians(130.f);        // Transversal floral slope
int development = 1;                  // Type P parastichy development: Counter clockwise: 1 ; clockwise = -1 
int parastichyType =2;                // For Beta<90 & 90<Gamma<180: 0 = 1P; 1 = 2P; 2 = 3P; 3 = 4P; 
                                      // For 90<Beta<180 & Gamma<90: 4 = 1S; 5 = 2S; 6 = 3S 
//  CONSTANTS
float gold = development * radians(137.50776405f);
float[] hztlIntercenterAngle  = {2.399963f, 0.916704f, 0.350150f, 0.133745f, -1.48325885f, -0.566554f, -0.216405f}; //  in Radians
int[] secondFlower = {1, 3, 8, 21, 2, 5, 13};    // second Embrionary flower unit. 0 = first flower

// VARIABLE DECLARATION
float horizontalInterCenter;          //  X distance between adjacent floral centers
float verticalInterCenter;            //  Y distance between adjacent floral centers
float distanceInterCenter;            //  Distance between floral centers
float embrionaryElevation;            //  Embrionary Y distance
float parastichyHeight;               // Parastichy height (mm) (altura envolvente/botones(2PI))

// CALCULUS OF VARIABLES
horizontalInterCenter = development * hztlIntercenterAngle[parastichyType];
verticalInterCenter   = horizontalInterCenter*tan(beta); 
distanceInterCenter = verticalInterCenter/sin(beta);    
embrionaryElevation = verticalInterCenter/(secondFlower[parastichyType]);
parastichyHeight = abs(2*PI/hztlIntercenterAngle[parastichyType] * embrionaryElevation); 

// REFERENCE TO ZERO INTER-VERTEX RELATIVE DISTANCES 
float x1 = parastichyHeight /(tan(gamma)-tan(beta));  
float y1 = x1*tan(gamma);
float x2 = x1 + distanceInterCenter*cos(beta);          
float y2 = y1 + distanceInterCenter*sin(beta);
float x3 = horizontalInterCenter;
float y3 = verticalInterCenter;

//GRAPHIC GENERATION
float pf = width/(2*PI);               // pixel factor
x1 = x1 * pf;
y1 = y1 * pf;
x2 = x2 * pf;
y2 = y2 * pf;
x3 = x3 * pf;
y3 = y3 * pf;
float x0 = 0;                          // Flower Po(x) inicialization
float y0 = height;                     // Flower Po(y) inicialization
int count = 0;
PFont f;
f = createFont("Arial",14); 
while(y0 >= 0){  
  textFont(f);
  fill(0);
  //text(count,x0, y0-(parastichyHeight * pf)/2);
  line(x0, y0, x0+ x1, y0 -y1);
  line(x0 + x1, y0 - y1, x0 + x2, y0 - y2);
  line(x0 + x2, y0 - y2, x0 + x3, y0 - y3);
  line(x0 + x3, y0 - y3, x0 , y0);
  count = count + 1;
  x0 = x0 + gold*pf;
  y0 = y0 - embrionaryElevation*pf; 
  if (development == 1 && x0 > width){
    x0 = x0 - width;
  }
  else if (development == -1 && x0 < 0){
    x0 = x0 + width;
  }    
}
//save("A_sanguineum_2D.tiff");
