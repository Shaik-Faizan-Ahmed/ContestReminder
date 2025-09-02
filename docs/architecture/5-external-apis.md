# 5. External APIs

## 5.1. CLIST.by API (Corrected)

-   **Purpose:** To fetch a list of upcoming coding contests from multiple platforms.
-   **Documentation:** [https://clist.by/api/v4/doc/](https://clist.by/api/v4/doc/)
-   **Base URL(s):** `https://clist.by/api/v4/`
-   **Authentication:** API Key. This key must be included in all requests.
-   **Rate Limits:** 10 requests per minute.

**Key Endpoints Used:**
-   `GET /api/v4/contest/` - This endpoint will be used to fetch a list of all contests. We will filter the results to show only upcoming contests.
-   `GET /api/v4/contest/{id}/` - Can be used to fetch details for a specific contest by its ID.

**Integration Notes:**
-   A `clist.by` API key is required and will need to be stored securely within the mobile application.
-   The rate limit is sufficient for our needs, but we should implement caching on the device to improve performance and avoid unnecessary API calls.
-   This single API will be the source for all contest data in the MVP.

---