# GodotWare - [Readmegit](https://www.github.com/mrtheduts/readmegit) 

<a href="https://xkcd.com/1597/" a="https://xkcd.com/1597/">
 <img align = "right" src=https://imgs.xkcd.com/comics/git.png  hspace="20" vspace="5">
</a>

## Índice:
1. [Inicializando o repositório](#inicializando-o-repositório)
2. [Começando a trabalhar](#começando-a-trabalhar)
   - [Coisas básicas](#coisas-básicas) 
   - [Lidando com `git-remote`](#lidando-com-git-remote)
   - [Usando tags](#usando-tags)
3. [Branches](#branches)
   - [Lidando com branches](#lidando-com-branches)
   - [Deletando branches](#deletando-branches)
   - [Fundindo dois branches](#fundindo-dois-branches)
4. [Dicas](#dicas)
5. [Links para referência](#links-para-referência)
   - [Links específicos mas possivelmente úteis](#links-específicos-mas-possivelmente-úteis)


<br />
<br />




## Inicializando o repositório:

Há duas maneiras de configurar uma pasta como um repositório git:
#### 1. `$ git init`
1. Criar uma pasta vazia/aproveitar uma pasta já existente
2. Entrar nela e inicializar o git : `$ git init`
3. Realizar o pull request: `$ git pull https://github.com/user/repo`
4. Configurar o endereço remoto do repositório:
   - Com https: `$ git remote add origin https://github.com/user/repo.git`
   - Com ssh: `$ git remote add origin ssh:git@github.com/user/repo.git`
   >Se enfrentar problemas para lidar com o endereço remoto, veja [Começando a trabalhar](#começando-a-trabalhar)
5. Criar um branch para sua implementação: `$ git checkout -b nome`
6. Dar push no branch: `$ git push origin nome`
7. **Codar hardmente**

#### 2. `$ git clone`
1. Clonar:
   - Com https: `$ git clone https://github.com/user/repo`
   - Com ssh: `$ git clone ssh:git@github.com/user/repo.git`
2. Ir até a pasta e criar um branch para sua implementação: `$ git checkout -b nome`
3. Dar push no branch: `$ git push origin nome`
4. **Codar hardmente**

<br />

## Começando a trabalhar

### Coisas básicas

 - Verificar arquivos modificados, adicionados e/ou removidos: `$ git status`
 - Adicionar arquivos para serem rastreados pelo repositório: `$ git add <arquivos>`
 - Registrar suas mudanças: `$ git commit [-a] [-m "Sua mensagem aqui"]`
     >As flags são opcionais. `-a` adiciona automaticamente os arquivos que foram modificados para esse commit; `-m` já realiza o commit com a mensagem entre aspas, pulando a etapa de abertura do editor de texto para a escrita do comentário.
 - Fazer upload para o repositório remoto: `$ git push origin <branch>`
 - Verificar os commits feitos e os seus autores: `$ git log [--oneline] [--graph]`
    >As flags são opcionais. `--oneline` deixa de lado algumas informações e mostra apenas a hash e o comentário do commit; `--graph` mostra os commits em estilo de grafo, com cada branch de uma cor;
    
    <br />

<p align="center"> 
 <a href=https://xkcd.com/1296/><img src=https://imgs.xkcd.com/comics/git_commit.png a=https://xkcd.com/1296/></a>
</p>

    
### Lidando com `git remote`
 - Para verificar qual o endereço do repositório: `$ git remote -v`
 - Para adicionar o endereço do repositório:
   - Com https: `$ git remote add origin https://github.com/user/repo.git`
   - Com ssh: `$ git remote add origin ssh:git@github.com/user/repo.git`
 - Para remover o endereço do repositório: `$ git remote remove origin`

### Usando Tags

Tags servem para manter um certo controle da versão "oficial" do programa, servindo de atalho para certos commits. Elas podem ser lightweight e annotated. As lightweight só contém informações do autor da tag, da data e do hash do commit. Já as annotated (adicionando a flag `-a`) guardam informações extras como o que mudou no commit, o autor original do repositório e podem ser verificadas pelo Gnu Privacy Guard.

 - Atualize a tag: `$ git tag [-a] vx.y.z [-m "Mudança"]`
 
    >Sugestão: sendo x = 0 ou 1 (projeto completo ou não), y += 1 a cada função adicionada e z += 1 quando bugs são corrigidos
    
  - Dê o upload das tags: `$ git push --tags`
  
  <br />

## Branches

<a href="https://xkcd.com/1421/" a="https://xkcd.com/1597/">
 <img align = "right" src=https://imgs.xkcd.com/comics/future_self.png  hspace="20" vspace="5">
</a>

### Lidando com branches

 - Ver os branches existentes e em qual está: `$ git branch`
 - Criar novo branch: `$ git branch <nome>`
 - Mudar de branch: `$ git checkout <nome>`
 - Criar (caso não exista) e mudar de branch: `$ git checkout -b <nome>`
 
### Deletando branches

- Localmente: `$ git branch -d <nome>`
- Remotamente: `$ git push origin --delete <nome>`
 
### Fundindo dois branches

1. Vá para o branch que continuará ativo
2. `$ git merge [--no-ff] <branch no qual mudanças foram feitas>`
    >Por que `--no-ff`? [`git merge` ou `git merge --no-ff`](http://stackoverflow.com/questions/9069061/what-is-the-difference-between-git-merge-and-git-merge-no-ff)
3. Resolva os conflitos
4. Adicione, commite e dê push nas mudanças

<br />

## Dicas

 - Configurar seu editor de texto padrão: `$ git config --global core.editor "seu_editor"`
 - Para não precisar dar login toda hora: `$ git config credential.helper 'cache --timeout=<nºsegundos>'`
 - [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh) é um ótimo plugin para seu terminal zsh (Ele pode ser bash, zsh, ksh...) com funcionalidades que auxiliam ao lidar com repositórios git
 - É produtivo automatizar certas tarefas com um [makefile](http://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/)
 - Se utiliza verificação em duas etapas, use uma [chave ssh](https://help.github.com/articles/connecting-to-github-with-ssh/) para se conectar pelo terminal.
 
<br />

## Links para referência
- [Git Docs](https://git-scm.com/documentation)
- [Blog do Git](https://git-scm.com/blog)
- [Git - The Simple Guide](http://rogerdudler.github.io/git-guide/)
- [Network Graph](https://github.com/blog/39-say-hello-to-the-network-graph-visualizer)

#### Links específicos, mas possivelmente úteis
 - [How to merge changes to a single file](http://stackoverflow.com/questions/10784523/how-do-i-merge-changes-to-a-single-file-rather-than-merging-commits)

<br />

## Tarefas:
- [X] Ler esse readme.
- [ ] Incluir instruções sobre rollback 

<br />

<p align="center"> 
 <a href=https://xkcd.com/292/><img src=https://imgs.xkcd.com/comics/goto.png></a>
</p>
<br />

*Autor: [@mrtheduts](https://github.com/mrtheduts/)*<br />
*Esse readme é de uso livre.* <br />
*Sugestões são bem-vindas.*
=======
# godotware

## Icon Credits
Arrow Keys icon made by Darius Dan from www.flaticon.com.
Mouse icon made by Freepik from www.flaticon.com.
