import pytz
import PIL.Image as Image
import io
import base64
from .imagebin import byte_data
from datetime import datetime, timedelta
from django.conf import settings

def _save_image(byte_data, csrf_token):
    # print(type(byte_data))
    # string_encode = byte_data.encode()
    string_encode = bytes(str(byte_data), 'utf-8')
    # print(string_encode[:23])
    # print(byte_data[:22])
    b = base64.b64decode(string_encode)
    img = Image.open(io.BytesIO(b))
    # img.show()

    img_prefix = csrf_token
    # path = f'.{settings.STATIC_URL[:-1]}{settings.MEDIA_URL[:-1]}{settings.UPLOAD_IMG}'
    path = f'.{settings.STATIC_URL[:-1]}{settings.MEDIA_URL[:-1]}/goods/'
    img_name = f'img_{img_prefix}.png'
    img_path_name = path+img_name

    img.save(img_path_name)

    return img_name