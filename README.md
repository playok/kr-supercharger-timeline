# Tesla Supercharger Timeline - Korea

대한민국 Tesla 슈퍼차저 설치 현황을 타임라인으로 시각화하는 웹 애플리케이션입니다.

## Features

- 슈퍼차저 설치 타임라인 재생/일시정지
- 날짜별 슈퍼차저 위치 지도 표시
- V2/V3/V4 버전별 마커 색상 구분
- 개소 수 및 충전기 수 실시간 카운트
- 폐쇄(Closed) 슈퍼차저 표시
- 모바일 반응형 레이아웃
- 다국어 지원 (한글/영어)

## Demo

[GitHub Pages](https://playok.github.io/kr-supercharger-timeline/)에서 확인할 수 있습니다.

## Tech Stack

- HTML5 / CSS3 / JavaScript (Vanilla)
- [Tailwind CSS](https://tailwindcss.com/) - 스타일링
- [Leaflet.js](https://leafletjs.com/) - 지도 라이브러리
- [CARTO Basemaps](https://carto.com/basemaps) - 타일 서버

## Data Source

슈퍼차저 데이터는 [supercharge.info](https://supercharge.info)에서 제공됩니다.

## Legend

| 색상 | 버전 |
|-----|------|
| Black | V4 (Next Gen) |
| Red | V3 (250kW) |
| Green/Red | V2 + V3 (Hybrid) |
| Green | V2 |
| Gray | Closed |

## Usage

1. 페이지 로드 시 `supercharger.json` 자동 로드
2. Play 버튼으로 타임라인 재생
3. 슬라이더로 특정 날짜 이동
4. 마커 클릭 시 상세 정보 확인

### Custom Data

"데이터 입력" 버튼을 통해 커스텀 JSON 데이터를 입력할 수 있습니다.

```json
{
  "results": [
    {
      "name": "Location Name",
      "dateOpened": "2024-01-01",
      "dateClosed": null,
      "gps": { "latitude": 37.5, "longitude": 127.0 },
      "stallCount": 8,
      "stalls": { "v3": 8 }
    }
  ]
}
```

## Scripts

### json_compact.sh

`supercharger.json`을 경량화된 `supercharger.minimal.json`으로 변환합니다.

```bash
# 필요: jq (brew install jq)
./json_compact.sh
```

**추출 필드:** `id`, `name`, `dateOpened`, `dateClosed`, `gps`, `stallCount`, `stalls`, `status`, `powerKilowatt`

## i18n

브라우저 언어 설정에 따라 자동으로 한글/영어가 적용됩니다.

- `ko*` → 한국어
- 그 외 → English

## License

MIT License

## Attribution

- Map data: [OpenStreetMap](https://www.openstreetmap.org/copyright) contributors
- Tiles: [CARTO](https://carto.com/attributions)
- Data: [supercharge.info](https://supercharge.info)
