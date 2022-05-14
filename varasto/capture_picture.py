import cv2
import numpy as np
class VideoCamera(object):
    def __init__(self):
        self.cap = cv2.VideoCapture(0)
    def __del__(self):
        self.cap.release()
    def get_frame(self):
        ret, frame = self.cap.read()
        # frame_flip = cv2.flip(frame, 1)
        ret, frame = cv2.imencode('.jpg', frame)
        return frame.tobytes()

    def take(self):
        ret, frame = self.cap.read()
        cv2.imwrite("NewPicture5.jpg", frame)
        return "NewPicture6.jpg"


# videoStreamObject = cv2.VideoCapture(0)
# cap, frame = videoStreamObject.read()
# cv2.imshow('Capturing Video',frame)
# cv2.imwrite("NewPicture.jpg",frame)


# videoCaptureObject = cv2.VideoCapture(0)
# while(True):
#     ret,frame = videoCaptureObject.read()
#     cv2.imshow('Capturing Video',frame)
#     if(cv2.waitKey(1) & 0xFF == ord('q')):
#         videoCaptureObject.release()
#         cv2.destroyAllWindows()


    