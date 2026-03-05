# 🛸 KIPARIS: Integration Profile Development Guide

An **Integration Profile** is an XML manifest that defines the "passport" of an external system. It instructs the KIPARIS platform on how to render fields in Parus 8, validate data types, and apply security policies.

## 🏗 XML Structure

### 1. System Header (`<system>`)

* **`code`**: Unique technical identifier (e.g., `DADATA`). Max 30 characters.
* **`name`**: Human-readable system name displayed in the UI.

### 2. Field Definitions (`<field>`)

Each field represents a specific parameter in the configuration. Attributes define its behavior.

**Core Attributes:**

* **`fld_code`**: Technical parameter key (e.g., `api_url`).
* **`fld_name`**: UI label or tooltip (up to 2000 characters).
* **`sort_order`**: Display sequence (recommended step — 10).

**Typing and Interface:**

* `data_type` (Physical data storage):
   * `0` — String (STR)
   * `1` — Number (NUM)
   * `2` — Date (DATE)
* `entry_type` (UI rendering mode):
   * `0` — **Manual Input** (standard text field).
   * `1` — **Secret Input** (masked with `***`, local **AES-256** encryption).
   * `2` — **Checkbox (Yes/No)**. Requires `data_type="1"`.
   * `3` — **Bundle (Container)**. A virtual field used as a placeholder for Vault secrets.

**Security Policy (stpolicy):**

* `0` — **Local:** Stored in the database in plain text.
* `1` — **Vault:** Stored in external secure storage (only a reference remains in the DB).
* `2` — **Hybrid:** Encrypted via **AES-256** in the local DB, with the option to migrate to Vault.

## 🔐 Working with Secret Groups (Bundling)

To combine multiple fields (e.g., login and password) into a single protected Vault package:

   1. **Donor Fields:** Assign the `bundle="имя_контейнера"` attribute to these fields.
   2. **Container Field:** Create a field with `fld_code="container_name"` and set `entry_type="3"`.

> Note: Fields with `entry_type="3"` are automatically hidden during initial configuration. they appear only after the "Tokenize/Vaultify" action is triggered.

## 🛠 Quick Start Example

```xml
<?xml version="1.0" encoding="UTF-8"?>
<kipintmanifest version="1.0">
  <system code="DADATA" name="DaData.ru">
    <fields>
      <field fld_code="api_token" 
             fld_name="API Токен" 
             sort_order="10" 
             entry_type="1" 
             data_type="0" 
             stpolicy="2" />
    </fields>
  </system>
</kipintmanifest>
```

*This manifest creates a masked field in Parus 8. The data will be encrypted using AES-256 at the database level to protect Archive Logs.*

## 🚀 Deployment

   1. Navigate to the **"Integration Types"** (Виды интеграций) section.
   2. Execute the **"Upload Profile"** (Загрузить профиль) action.
   3. Select your XML file.
   4. The system will automatically sync metadata without affecting existing client connections.
