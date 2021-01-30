from os import getenv, makedirs
from os.path import exists
from pathlib import Path
from hashlib import sha1
from bottle import run, get, post, request, FileUpload, static_file, abort

class Storage:
    data_dir: str
    def __init__(self, data_dir: str):
        makedirs(data_dir, exist_ok=True)
        self.data_dir = data_dir

    def path(self, tag: str):
        return f'{self.data_dir}/{tag}'

    def upload(self, contents: FileUpload):
        tag = self.get_tag(contents)
        contents.save(self.path(tag))
        return tag

    def get_tag(self, contents: FileUpload):
        hasher = sha1()
        while len(buf := contents.file.read(65536)) > 0:
            hasher.update(buf)
        contents.file.seek(0)
        h = hasher.hexdigest()
        for i in range(1, len(h) + 1):
            tag = h[:i]
            if not exists(self.path(tag)):
                return tag

        raise RuntimeError('Failed to get tag')

storage = Storage(getenv('DATA_DIR', '/data'))

@get('/')
def index():
    return '''
        <form method="POST" enctype="multipart/form-data">
            <input name="file" type="file" />
            <input value="Upload" type="submit" />
        </form>
    '''

@post('/')
def post_index():
    f = request.files.get('file')
    if f is None:
        return abort(400)
    tag = storage.upload(f)
    return f'{request.url}{tag}'

@get('/<tag>')
def get_index_tag(tag: str):
    return static_file(tag, storage.data_dir, mimetype='text/plain')

if __name__ == "__main__":
    run(host='0.0.0.0', port=int(getenv('PORT', '8080')), debug=True)
