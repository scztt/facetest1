import codeanticode.gsvideo.*; 
import monclubelec.javacvPro.*; 
import java.awt.*; 

PImage img;
Rectangle[] faceRect; 

GSCapture cam; 
OpenCV opencv; 

int widthCapture=320; 
int heightCapture=240; 
int fpsCapture=30; 

void setup() { 
  size (widthCapture, heightCapture); 
  frameRate(fpsCapture);  
  cam = new GSCapture(this, widthCapture, heightCapture); 
  opencv = new OpenCV(this); 
  opencv.allocate(widthCapture, heightCapture); 
  cam.start();  
  opencv.cascade("/opt/local/share/OpenCV/haarcascades/","haarcascade_frontalface_alt.xml"); 
}

void  draw() { 
  if (cam.available() == true) { 
    cam.read(); 
    img=cam.get(); 
    opencv.copy(img); 
    image(img,0,0); 
    g.removeCache(img); //PImage memory leak workaround
    faceRect = opencv.detect(3,true); 
    opencv.drawRectDetect(true); 
  }
} 
