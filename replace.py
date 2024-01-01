import os


def rree(path):
    with open(path, 'r') as f:
        content = f.read()
        newContent = content.replace('$$', 'MMMMMM').replace('$', '$$').replace('MMMMMM', '$$')
    with open(path, 'w') as f:
        f.write(newContent)


for path in os.listdir('./'):
    if '.git' in path or '.idea' in path:
        continue
    if os.path.isdir(path):
        for subPath in os.listdir(path):
            if os.path.isdir(f'{path}/{subPath}'):
                for subsubPath in os.listdir(f'{path}/{subPath}'):
                    if os.path.isdir(f'{path}/{subPath}/{subsubPath}'):
                        print(f'{path}/{subPath}/{subsubPath}')
                    if '.md' in subsubPath:
                        rree(f'{path}/{subPath}/{subsubPath}')
            if '.md' in subPath:
                rree(f'{path}/{subPath}')
    if '.md' in path:
        rree(f'{path}')
print('DONE')
