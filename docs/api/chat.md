# API: Chat

## GET `/api/chat/{roomId}/messages`

**Lấy thêm tin nhắn cũ hơn trong phòng chat**

Dùng khi mobile scroll lên: truyền beforeMessageId là id tin nhắn cũ nhất client đang có. Response luôn ordered ascending by createdAt.

### Parameters

| Name | In | Type | Required | Description |
|------|----|------|----------|-------------|
| roomId | path | string | true |  |
| beforeMessageId | query | string | false |  |
| limit | query | string | false |  |

### Responses

**200** — Phản hồi thành công

Response data schema:

#### `ChatMessagesPageResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `messages` | `ChatMessageDto[]` | Yes |  |
| `nextBeforeMessageId` | string | No | Message id cũ nhất trong page hiện tại, dùng làm beforeMessageId cho page kế tiếp |
| `hasMore` | boolean | Yes | true |

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

#### `ChatMessagesPageResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `messages` | `ChatMessageDto[]` | Yes |  |
| `nextBeforeMessageId` | string | No | Message id cũ nhất trong page hiện tại, dùng làm beforeMessageId cho page kế tiếp |
| `hasMore` | boolean | Yes | true |

#### `ChatImageUploadResponseDto`

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `message` | `ChatMessageDto` | Yes |  |

