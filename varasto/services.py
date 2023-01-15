import PIL.Image as Image
import io
import base64
from .imagebin import byte_data
from django.conf import settings
from pathlib import Path
import uuid


def _save_image(byte_data, csrf_token) -> str:
    """Save picture to image/goods directory,
    if generated filename does not exist
    Return: Image filename
    """
    string_encode = bytes(str(byte_data), 'utf-8')
    b = base64.b64decode(string_encode)
    img = Image.open(io.BytesIO(b))

    while True:
        print('While loop')
        new_filename = filename_generator()
        is_file_exist = Path(new_filename['file_path']).is_file()
        if not is_file_exist:
            break

    img.save(new_filename['file_path'])

    return new_filename['image_name']

def filename_generator() -> dict:
    """ Generate file name with prefix <pr_> and extention <.png>
    Return: dict
        [file_path]: Path to product images folder
        [image_name]: Filename
    """
    path = f'.{settings.STATIC_URL[:-1]}{settings.MEDIA_URL[:-1]}/goods/'
    img_prefix = uuid.uuid4().hex
    img_name = f'pr_{img_prefix}.png'
    img_path_name = path+img_name
    return {'file_path': img_path_name, 'image_name': img_name}