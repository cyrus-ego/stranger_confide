# API: Chat

## POST `/api/chat/{roomId}/image`

**Upload ảnh trong phòng chat**

Text chat qua WebSocket event chat:send — không có REST endpoint

### Parameters

| Name | In | Type | Required | Description |
|------|----|------|----------|-------------|
| roomId | path | string | true |  |

### Request Body

Content-Type: `multipart/form-data`

```json
{
  "type": "object",
  "required": [
    "image"
  ],
  "properties": {
    "image": {
      "type": "string",
      "format": "binary",
      "description": "JPEG, PNG, WebP, GIF"
    }
  }
}
```

### Responses

**201** — Phản hồi thành công

Response data schema:

#### `ChatImageUploadResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `message` | `ChatMessageDto` | Yes |  |

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

#### `ChatImageUploadResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `message` | `ChatMessageDto` | Yes |  |

