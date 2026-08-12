<p align="center">
  <img align="center" src=".github/header.png" alt="End of Eden 헤더" />
</p>

<p align="right">
  <a href="README.md">🇬🇧 English</a> · <a href="README.ko.md">🇰🇷 한국어</a>
</p>

[![Discord](https://img.shields.io/discord/1099310842564059168?label=discord)](https://discord.gg/XpDvfvVuB2) [![Go Report Card](https://goreportcard.com/badge/github.com/BigJk/end_of_eden)](https://goreportcard.com/report/github.com/BigJk/end_of_eden) [![GitHub release (latest by date)](https://img.shields.io/github/v/release/BigJk/end_of_eden)](https://github.com/BigJk/end_of_eden/releases) [![License](https://img.shields.io/github/license/BigJk/end_of_eden)](LICENSE)

<a href="https://bigjk.itch.io/end-of-eden"><img align="right" src="http://jessemillar.github.io/available-on-itchio-badge/badge-bw.png" width="130" alt="itch.io에서 플레이"></a>

# End of Eden

> *미래 500년 뒤, 기후 변화와 핵전쟁으로 황폐해진 세계. 남은 인간은 거의 사라지고, 그 자리엔 변이체와 식물 기반 생물들이 득세합니다.*
>
> *이 곤조-판타지 세계관 속에서, 당신은 잊혀진 지하 시설의 냉동 수면에서 깨어납니다. 다른 캡슐은 모두 깨져 있고, 당신만 홀로 눈을 뜹니다. 낯설고 위험한 세계를 헤쳐 나가며, 당신의 격리가 어떤 비밀로 인한 것인지 밝혀내야 합니다...*

**End of Eden**은 *Slay the Spire* 스타일의 **로그라이트 덱빌더** 게임입니다. 터미널에서 완전히 동작하지만, 익숙하지 않다면 전용 창(GL 버전)에서 즐기실 수도 있어요.

- 🃏 새로운 카드와 다양한 패시브 효과를 주는 아티팩트 수집
- 👹 기이한 존재들과의 전투 — 가능한 한 오래 살아남기
- 🎨 CRT 셰이더, 그레인 셰이더로 더 깊은 레트로 분위기
- 🛠️ **Lua 모드 시스템**으로 자신만의 카드·적·아티팩트 추가
- 🌏 한국어 포함 다국어 지원 (`assets/locals/`)

---

# 목차

- [스크린샷](#스크린샷)
- [상태](#상태)
- [빠른 시작](#빠른-시작)
- [게임 방법](#게임-방법)
  - [다운로드](#다운로드)
  - [Docker](#docker)
  - [설정](#설정)
  - [콘솔](#콘솔)
- [모딩 — Lua](#모딩--lua)
- [흥미로운 이야기](#흥미로운-이야기)
- [빌드](#빌드)
- [버전 관리](#버전-관리)
- [소셜](#소셜)
- [크레딧](#크레딧)
- [라이선스](#라이선스)

---

# 스크린샷

![GL 버전 스크린샷](.github/screenshot_gl1.png)
![GL 버전 스크린샷 2](.github/screenshot_gl3.png)

<details>
<summary>터미널 버전 스크린샷 보기</summary>

![터미널 버전 스크린샷](.github/screenshot.png)
![상점 화면](.github/screenshot_merchant.png)

</details>

---

# 상태

게임은 아직 **초기 개발 단계**입니다. 빠진 콘텐츠가 많고 밸런스도 전혀 잡혀 있지 않아서 현재는 대부분 테스트 콘텐츠만 들어 있습니다.

기여하고 싶으시다면 이슈나 풀 리퀘스트를 열어주세요. 더 좋은 방법은 [Discord](https://discord.gg/XpDvfvVuB2)에 참여해 직접 이야기 나누는 것입니다.

---

# 빠른 시작

| 하고 싶은 것 | 추천 버전 |
|---|---|
| 일단 게임만 가볍게 테스트해 보고 싶다 | `_gl` 버전 다운로드 |
| 터미널을 떠나고 싶지 않다 / SSH로 원격 플레이 | `_term` 버전 다운로드 |
| 도커에 익숙하다 | `ghcr.io/bigjk/end_of_eden` 이미지 |
| 카드/적/아티팩트를 직접 만들어 보고 싶다 | `cmd/game/` 소스 빌드 + Lua 모딩 |

> 💡 두 버전 모두 게임플레이는 완전히 동일합니다. 차이는 **렌더링 방식**(터미널 vs OpenGL 창)뿐이에요.

---

# 게임 방법

## 다운로드

1. 본인의 OS에 맞는 최신 게임 버전은 [Releases](https://github.com/BigJk/end_of_eden/releases)에서 다운로드하세요.
2. 파일 이름으로 버전을 구분할 수 있습니다.
   - `end_of_eden_term` — 터미널 버전 (기본 게임)
   - `end_of_eden_gl` — GL 버전 (전용 창, CRT/그레인 셰이더 옵션)
3. 터미널에 익숙하지 않다면 `_gl` 버전을 시도해 보세요.

> ⚠️ `_term` 버전의 마우스 컨트롤 등 모든 기능을 사용하려면 **모던 터미널**이 필요합니다. 자세한 내용은 [콘솔](#콘솔) 섹션을 참조하세요.

## Docker

<details>
<summary>Docker 가이드 펼치기</summary>

고급 사용자라면 도커로도 게임을 실행할 수 있습니다.

### 이미지 가져오기

```bash
docker pull ghcr.io/bigjk/end_of_eden:master
```

### 기본 게임

기본 게임을 도커로 실행할 수 있지만 **오디오는 지원되지 않습니다**. 환경 플래그로 터미널 기능을 명시해야 합니다. 아래 예제는 `xterm-256color` 터미널과 트루 컬러를 활성화합니다.

```bash
docker run --name end_of_eden \
  -e TERM=xterm-256color \
  -e COLORTERM=truecolor \
  -it ghcr.io/bigjk/end_of_eden:master \
  /app/end_of_eden --audio=false
```

`TERM` 환경 변수의 가능한 옵션:

- `xterm-256color`
- `xterm`
- `screen-256color`
- `screen`
- `vt100`
- 등...

`COLORTERM`은 터미널이 트루 컬러를 지원하는지 정의합니다. 모던 터미널이라면 `truecolor`로 설정해도 안전합니다. 다른 옵션은 `24bit`, `16mil`, `8bit`입니다.

### SSH 서버

```bash
docker run --name end_of_eden -p 8275:8273 -it ghcr.io/bigjk/end_of_eden:master /app/end_of_eden_ssh
```

</details>

## 설정

두 버전 모두 별도의 설정 파일을 가집니다. 설정 파일은 게임 실행 파일과 같은 위치에 있고, 첫 게임 시작 시 자동으로 생성됩니다. 설정 파일이나 게임 내 설정 메뉴에서 변경할 수 있어요.

### `_term` 버전

- 설정 파일: `settings_term.toml`
- 게임 내 설정 메뉴로 변경 가능

<details>
<summary><code>settings_term.toml</code> 사용 가능한 설정</summary>

```toml
# 오디오 볼륨
#
volume = 1.0

# 로드할 모드 (게임 내에서도 수정 가능)
#
mods = [ "example_mod", "other_mod" ]
```

</details>

### `_gl` 버전

- 설정 파일: `settings_gl.toml`
- 게임 내 설정 메뉴로 변경 가능

<details>
<summary><code>settings_gl.toml</code> 사용 가능한 설정</summary>

```toml
# 오디오 볼륨
#
volume = 1.0

# 로드할 모드 (게임 내에서도 수정 가능)
#
mods = [ "example_mod", "other_mod" ]

# 오디오 활성화 여부
#
audio = true

# CRT 셰이더 활성화 여부
#
crt = true

# 그레인 셰이더 활성화 여부
#
grain = true

# DPI 스케일링
#
dpi = 1

# 일반, 이탤릭, 굵은 텍스트에 사용될 폰트.
# 폰트는 ./assets/fonts를 기준으로 상대 경로여야 합니다.
# Nerd Font 사용을 권장합니다: https://www.nerdfonts.com/font-downloads
#
font_normal = 'BigBlueTermPlusNerdFont-Regular.ttf'
font_italic = 'BigBlueTermPlusNerdFont-Regular.ttf'
font_bold = 'BigBlueTermPlusNerdFont-Regular.ttf'

# 폰트 크기
#
font_size = 12

# 최대 FPS
#
fps = 30

# 창 크기
#
height = 800
width = 1100
```

</details>

## 콘솔

`_term` 버전의 마우스 컨트롤 등 모든 기능을 지원하려면 **모던 콘솔**이 필요합니다. 터미널에서 `end_of_eden(.exe)` 실행 파일을 시작하면 됩니다.

### 테스트된 터미널

| 터미널 | OS | 상태 | 비고 |
|---|---|---|---|
| **[Windows Terminal](https://github.com/microsoft/terminal)** | Windows | ✅ 권장 | Windows에서 가장 잘 동작 |
| **cmd** | Windows | ⚠️ 제한 | 마우스 모션 미지원, 클릭 및 기타 기능은 동작 |
| **[iTerm2](https://iterm2.com/)** | macOS | ✅ | |

---

# 모딩 — Lua

**Lua**는 게임에서 아티팩트, 카드, 적 등 동적인 모든 것을 정의하는 데 사용됩니다. 그래서 End of Eden을 쉽게 확장할 수 있어요.

| 문서 | 설명 |
|---|---|
| [Lua 문서](docs/LUA_DOCS.md) | Lua 바인딩 전체 가이드 |
| [Lua API 레퍼런스](docs/LUA_API_DOCS.md) | 자동 생성된 API 문서 |
| [게임 콘텐츠 문서](docs/GAME_CONTENT_DOCS.md) | 카드/적/아티팩트 작성법 |

### 예제 모드 위치

- 모드 디렉토리: `mods/`
- 한국어 번역: `assets/locals/ko/`

---

# 흥미로운 이야기

> 게임을 직접 만들면서 정말 재밌었던 부분들을 모아뒀어요.

<details>
<summary><b>게임은 자체 터미널 에뮬레이터를 가지고 있습니다</b></summary>

게임은 터미널에서 완벽하게 동작하지만, 비-터널 사용자도 터미널을 직접 다루지 않고 게임을 플레이할 수 있는 방법을 제공하고 싶었습니다. 그래서 "Go로 간단한 터미널 에뮬레이터를 만드는 게 얼마나 어려울까?"라고 생각했습니다.

놀랍게도 그다지 어렵지 않았습니다. [CRT](https://github.com/BigJk/crt)를 작성하면서 정말 재밌게 놀랐고, 좋은 부수 효과로 게임에 더 레트로한 느낌을 주는 CRT 셰이더를 포함할 수 있었습니다.

</details>

<details>
<summary><b>게임에는 퍼지 테스터가 있습니다</b></summary>

Lua 스크립팅을 처음 통합할 때 많은 문제에 부딪혔습니다. 단순한 nil 역참조부터 Lua가 폭주하는 것까지, Lua 코드를 디버깅하는 게 Go 자체를 디버깅하는 것만큼 쉽지 않았습니다.

특정 이벤트 체인이 패닉을 일으키는 게임 코드의 엣지 케이스가 많았고, 이를 대응하기 위해 게임에 **무작위 순서로 연산을 던져 패닉을 유발하는 작은 퍼지 테스터**를 구현했습니다. 패닉이 발생하면 어떤 연산 체인이 어떤 값과 함께 패닉을 일으켰는지 보여줍니다.

```go
func castCardOp(rnd *rand.Rand, s *game.Session) string {
    guid := Shuffle(rnd, lo.Flatten([][]string{{""}, s.GetInstances(), s.GetActors()}))[0]
    target := Shuffle(rnd, lo.Flatten([][]string{{""}, s.GetInstances(), s.GetActors()}))[0]
    s.CastCard(guid, target)
    return fmt.Sprintf("Cast card with guid '%s' on '%s'", guid, target)
}
```

이는 게임의 CI에도 통합되어 있습니다. Lua나 Go를 변경하는 커밋이 푸시될 때마다, 퍼지 테스터는 2 코어에서 30초 동안 실행되며 실패하면 CI 파이프라인이 실패합니다.

코드는 `cmd/internal/fuzzy_tester`에서 확인할 수 있습니다.

</details>

<details>
<summary><b>게임 콘텐츠는 단위 테스트가 가능합니다</b></summary>

게임 콘텐츠를 손으로 테스트하거나 예상대로 동작하는지 확인하는 게 번거로울 수 있습니다. 다행히 "End of Eden"은 단순한 턴 기반 게임이며 복잡한 3D 작업이 없습니다. 그렇다면 왜 카드, 아티팩트 등을 단위 테스트하지 않을까요?

그래서 등록된 모든 게임 콘텐츠에서 테스트 함수를 실행하는 작은 테스트 유틸리티를 작성했습니다. 다음은 BLOCK 상태 효과의 테스트 예제입니다. 각 테스트마다 깨끗한 게임 상태가 생성되고 주어진 게임 콘텐츠가 플레이어에게 주어집니다.

```lua
register_status_effect("BLOCK", {
    name = "Block",
    description = "Decreases incoming damage for each stack",
    -- ...
    test = function()
        return assert_chain({
            function() return assert_status_effect_count(1) end,
            function() return assert_status_effect("BLOCK", 1) end,
            function ()
                local dummy = add_actor_by_enemy("DUMMY")
                local damage = deal_damage(dummy, PLAYER_ID, 1)
                if damage ~= 0 then
                    return "Expected 0 damage, got " .. damage
                end
                damage = deal_damage(dummy, PLAYER_ID, 2)
                if damage ~= 2 then
                    return "Expected 2 damage, got " .. damage
                end
            end
        })
    end
})
```

이것도 게임의 CI에 통합되어 있습니다. Lua나 Go를 변경하는 커밋이 푸시될 때마다 테스터가 실행되며 실패하면 CI 파이프라인이 실패합니다.

코드는 `cmd/internal/tester`에서 확인할 수 있습니다.

</details>

<details>
<summary><b>게임은 자체 Lua 문서와 자동 완성을 생성합니다</b></summary>

Lua와 그 문법을 그다지 좋아하지 않지만, 거의 모든 언어에 쉽게 임베드할 수 있다는 점이 마음에 듭니다. 그래서 그 사실이 문법에 대한 개인적인 단점보다 더 컸습니다. 제가 놓치고 있던 유일한 것은 **게임 API에 대한 멋진 자동 완성**이었습니다.

그때 [lua-language-server](https://github.com/LuaLS/lua-language-server)와 정의에 대한 훌륭한 지원에 대해 알게 되었습니다. 그래서 게임에서 변하지 않는 것들의 기본 정의를 작성했고, 나머지는 게임이 동적으로 생성합니다.

지금은 마크다운 기반 문서와 언어 서버용 주석을 생성하는 유틸리티가 있습니다. Lua 문서는 [`docs/LUA_API_DOCS.md`](docs/LUA_API_DOCS.md)에서, 정의는 `assets/scripts/definitions`에서 찾을 수 있습니다. 문서는 Lua 함수와 상수를 정의하는 코드에 함께 정의되어 있어요.

```go
d.Global("PLAYER_ID", "Player actor id for use in functions where the guid is needed, for example: `deal_damage(PLAYER_ID, enemy_guid, 10)`.") // <- docs
l.SetGlobal("PLAYER_ID", lua.LString(PlayerActorID)) // <- lua

d.Function("guid", "returns a new random guid.", "guid") // <- docs
l.SetGlobal("guid", l.NewFunction(func(state *lua.LState) int {
    state.Push(lua.LString(NewGuid("LUA")))
    return 1
})) // <- lua
```

이는 다음과 같은 Lua 정의를 만듭니다:

```lua
--- Player actor id for use in functions where the guid is needed, for example: `deal_damage(PLAYER_ID, enemy_guid, 10)`.
PLAYER_ID = ""

--- returns a new random guid.
---@return guid
function guid() end
```

`/assets/scripts` 폴더를 Visual Studio Code와 [Lua 확장](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)으로 열면 타이핑할 때 멋진 자동 완성(대부분의 경우)을 얻을 수 있어 스크립팅 경험이 훨씬 좋아집니다!

![Lua 자동 완성](.github/lua_autocomplete.png)

코드는 `cmd/internal/docs`에서 확인할 수 있습니다.

</details>

---

# 빌드

## 자동 빌드

`./build.sh` 스크립트를 사용해 모든 바이너리를 빌드할 수 있습니다. 스크립트는 `bin` 폴더를 만들고 모든 바이너리와 에셋을 그 안에 넣습니다. 시스템에 Go가 설치되어 있지 않다면 [pkgx](https://pkgx.dev/)를 통해 자동으로 가져와 실행하라는 메시지가 표시됩니다. pkgx는 자체 설치 없이 다양한 프로그램을 실행할 수 있는 패키지 관리 도구입니다.

```bash
./build.sh
```

## 수동 빌드

- Go **`>= 1.20`** 필요 (`go.mod` 기준 `1.23`)
- 터미널 버전:
  ```bash
  go build -o ./build/end_of_eden ./cmd/game/
  ```
- GL 버전 (Windows):
  ```bash
  go build -o ./build/end_of_eden.exe ./cmd/game_win/
  ```
- 빌드 없이 실행:
  ```bash
  go run ./cmd/game/
  ```

> ⚠️ **중요:** 게임의 작업 디렉토리는 `./assets` 폴더가 사용 가능한 곳이어야 합니다!

---

# 버전 관리

이 게임은 [의미론적 버전 관리(SemVer)](https://semver.org/)와 유사한 방식으로 버전 번호를 정의합니다. 이는 [Go Modules](https://go.dev/doc/modules/version-numbers) 버전 관리 체계와도 일치합니다.

**v`Major`.`Minor`.`Patch`**

- **Major** — 게임 개발의 주요 마일스톤. `0` Major 버전은 초기 개발 단계를 나타내며, 아직 확정된 것이 없고 모든 것이 변경될 수 있습니다.
- **Minor** — 새로운 기능이나 중요한 변경.
- **Patch** — 작은 변경, 버그 수정 및 개선.

---

# 소셜

- **itch.io**: https://bigjk.itch.io/end-of-eden
- **IndieDB**: https://www.indiedb.com/games/end-of-eden
- **Discord**: https://discord.gg/XpDvfvVuB2

---

# 크레딧

- 얼굴 데이터를 공개한 **Huw Millward** — [Warsim Generator Toolbox](https://huw2k8.itch.io/warsims-generator-toolbox)
- **Bleeoop**의 [Interface Beep Sounds](https://bleeoop.itch.io/interface-bleeps)
- **Juhani Junkala**의 [512 Sound Effect Pack](https://opengameart.org/content/512-sound-effects-8-bit-style)
- 음악 및 추가 오디오 작업 — [synthroton](https://synthroton.bandcamp.com/)

---

# 라이선스

- **코드**: [MIT 라이선스](LICENSE)
- **에셋**: 해당 폴더의 `README.md` 참조