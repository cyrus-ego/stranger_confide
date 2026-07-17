# API: Moderation

## POST `/api/moderation/report`

**Báo cáo user trong phòng chat**

### Request Body

Content-Type: `application/json`

#### `ReportDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `reportedUserId` | string | Yes |  |
| `roomId` | string | Yes |  |
| `reason` | enum: spam, harassment, inappropriate_content, personal_info, other | Yes |  |
| `description` | string | No |  |


### Responses

**201** — Phản hồi thành công

Response data schema:

#### `ReportCreatedResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `message` | string | Yes | Đã ghi nhận báo cáo. Cảm ơn bạn đã giúp cộng đồng an toàn hơn. |
| `reportId` | string | Yes | 665a1b2c3d4e5f6789012345 |

**400** — Dữ liệu không hợp lệ

Schema: `ApiErrorResponseDto` (xem `common.md`)

**401** — Chưa xác thực

Schema: `ApiErrorResponseDto` (xem `common.md`)

**403** — Không có quyền

Schema: `ApiErrorResponseDto` (xem `common.md`)

**404** — Không tìm thấy

Schema: `ApiErrorResponseDto` (xem `common.md`)

**429** — Quá nhiều yêu cầu

Schema: `ApiErrorResponseDto` (xem `common.md`)

---

## Schemas

#### `ReportDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `reportedUserId` | string | Yes |  |
| `roomId` | string | Yes |  |
| `reason` | enum: spam, harassment, inappropriate_content, personal_info, other | Yes |  |
| `description` | string | No |  |

#### `ReportCreatedResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `message` | string | Yes | Đã ghi nhận báo cáo. Cảm ơn bạn đã giúp cộng đồng an toàn hơn. |
| `reportId` | string | Yes | 665a1b2c3d4e5f6789012345 |

