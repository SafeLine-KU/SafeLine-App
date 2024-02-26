<p align="center">
<img src="https://avatars.githubusercontent.com/u/157958039?s=200&v=4" width=15%><br>
Solution to increase users' disaster literacy<br>
<strong>SafeLine</strong>
</p>

# SafeLine-App

> This `README` is written in English, with a [Korean version(한국어)](#safeline-app-한국어-해설) below.

This repository contains the Client Application code for the SafeLine project. This document contains a brief description of the project and instructions for running it.

## 📖 Overview

> Many people are not prepared for disasters. Current disaster warning systems and responses have limitations.

**SafeLine** is a solution aimed at improving users' disaster literacy.

- It generates instructions considering the user's location and situation (characteristics of the place, age, disabilities, etc.) and guides them to shelters.
- It creates intuitive images to accurately convey instructions even to users who find it difficult to understand text.
- It utilizes generative AI to respond to nex and complex disasters (such as climate change).
- By providing essay quizzes and feedback, it allows users to interact with the system and learn response methods.

## ⚙️ How to Run  

> Before running, please proceed with the installation of `Flutter` according to the official documentation.
> Additionally, ensure that the SDK environment for the build target OS is set up in advance.

1. Clone this repository.

```bash
git clone https://github.com/SafeLine-KU/SafeLine-App.git
```

2. Build and run `Flutter`.

```bash
flutter run
```

## 💻 Products/Platforms Used

- `Flutter`
- `Google Maps`
- `Google Cloud Platform`
  - `Cloud Run`
  - `Cloud Storage`
  - `BigQuery`
- Generative AI
  - `Gemini`(Pro 1.0 model)
  - `DALL·E 3`
- `FastAPI`

---

# SafeLine-App 한국어 해설

이 레포지토리는 SafeLine 프로젝트의 클라이언트 애플리케이션 코드입니다.  
본 문서는 프로젝트에 대한 간단한 설명과 실행에 관한 내용을 담고 있습니다.  

## 📖 개요  

> 많은 이는 재난 속에서 원활히 대응하지 못한다. 지금의 재난 경고 시스템과 대응법에 한계가 있다.  

**SafeLine**은 사용자의 재난 문해력을 향상시키기 위한 솔루션입니다.  

- 사용자의 위치와 상황(장소의 특성, 나이, 장애 등)을 고려해 행동요령을 생성하고, 대피소와 함께 안내합니다.
- 직관적인 이미지를 생성하여, 글을 이해하기 어려운 사용자에게도 정확하게 행동요령을 전달합니다.  
- 생성형 AI를 활용해, 신종,복합재난(기후변화 등)까지 대응합니다.
- 주관식 방식의 퀴즈와 피드백을 제공함으로써 사용자가 시스템과 상호작용하며, 대응법을 익힐 수 있도록 합니다.

## ⚙ 실행방법

> 실행 전, 공식문서에 따라 `Flutter` 설치를 진행해주세요.
> 또한, 빌드 타겟 OS의 SDK 환경을 미리 구축해놓으세요.

1. 본 레포지토리를 clone해주세요.

```bash
git clone https://github.com/SafeLine-KU/SafeLine-App.git
```

2. `Flutter` 를 빌드해 실행해주세요.

```bash
flutter run
```

## 💻 사용한 제품/플랫폼  
- `Flutter`
- `Google Maps`
- `Google Cloud Platform`
  - `Cloud Run`
  - `Cloud Storage`
  - `BigQuery`
- Generative AI
  - `Gemini`(Pro 1.0 model)
  - `DALL·E 3`
- `FastAPI`
