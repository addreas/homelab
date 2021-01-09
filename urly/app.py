from redis import Redis
from os import getenv
from bottle import run, get, post, redirect, request, abort

storage = Redis(host=getenv('REDIS_HOST', 'redis'), port=int(getenv('REDIS_PORT', '6379')))

def get_tag(url):
    h = hex(abs(hash(url)))[2:]
    for i in range(1, len(h) + 1):
        tag = h[:i]
        existing = storage.get(tag)
        if existing is None or existing.decode() == url:
            return tag

    raise RuntimeError('Failed to get key')

def set_url(url):
    tag = get_tag(url)
    storage.set(tag, url)
    return tag

def get_url(tag):
    url = storage.get(tag)
    if url is not None:
        return url.decode()

@get('/')
def index():
    return '''
        <form method="POST">
            <input name="url" type="text" placeholder="http://example.com/long-url"/>
            <input value="Get URL" type="submit" />
        </form>
    '''

@post('/')
def post_index():
   tag = set_url(request.forms.get('url'))
   return f'{request.url}{tag}'

@get('/<tag>')
def get_index_tag(tag):
    url = get_url(tag)
    if url is not None:
        return redirect(url)
    else:
        return abort(404, 'Not found')

if __name__ == "__main__":
    run(host='0.0.0.0', port=int(getenv('PORT', '8080')))
