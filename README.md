### Desafio GuiaBolso

Desafio realizado para processo seletivo do guiabolso, onde fora proposto uma aplicação ios com consumo da api do chucknorris.

Tecnologias utilizadas:
- Swift 5.0
- Arquitetura MVVM
- XCTest
- RxSwift
- RxCocoa
- Cocoapods
- Moya

## Requisitos

- iOS 10.0+ / Mac OS X 10.15+
- Xcode 11.7+
- Swift 5.0+

## Instalação

### Projeto

Clone o repositório com o comando a seguir:
```bash
$ git clone https://github.com/carolgomss/DesafioGuiaBolso.git
```

### CocoaPods

[CocoaPods](http://cocoapods.org) é um gerenciador de dependências para projetos. Para instalar utilize o seguinte comando:

```bash
$ gem install cocoapods
```
No arquivo `Podfile` foram instaladas as seguintes dependências usando Cocoapods:

```ruby
    pod 'Moya/RxSwift', '~> 14.0'
    pod 'RxSwift', '5.0'
    pod 'RxCocoa'
```

Para rodar, entre na pasta do projeto pelo terminal e utilize o comando:

```bash
$ pod install
```
Em seguida, para abrir o projeto execute o comando:

```bash
$ open ChuckNorris.xcworkspace
```

## Decisões Técnicas

- ViewCode: velocidade em renderizar e abrir o projeto, reduz o travamento deixando mais seguro.
- Moya: Conseguir tratar os endpoints com enum, abstraindo numa camada de rede e então conseguir facilitar o desenvolvimento e manutenção.
- RxCocoa: Permitiu transformar os componentes de UIKit em elementos reativos para trabalhar em conjunto com RxSwift.
- Arquitetura MVVM: Facilitaria fazer testes unitários já que a camada de View está separada da regra de negócio.
- Testes funcionais: UITest implementado utilizando XCTest 
