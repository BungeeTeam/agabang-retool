# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Retool application repository containing 118 business intelligence and analytics applications for a multi-brand retail company. Apps are version-controlled using Git and deployed to Retool's platform.

**Key Brands:**
- **Ettoi (에뜨와)**: 33 apps - Children's fashion brand
- **Agabang (아가방)**: 23 apps - Baby products brand
- **Disney (디즈니)**: 25 apps - Licensed Disney merchandise

**Functional Apps:**
- **영업 (Sales)**: 14 apps - Sales analytics and store management
- **발주최적화**: Order optimization and store distribution
- **버그 제보_개선 요청**: Issue tracking and feature requests

## Architecture

### Directory Structure

```
apps/                  # Retool applications (118 total)
├── 01. EttoiApp/     # Brand-specific apps for Ettoi, main user is  MD
├── 02. AgabangApp/   # Brand-specific apps for Agabang, main user is  MD
├── 03. DisneyApp/    # Brand-specific apps for Disney, main user is  MD
├── 04. 발주최적화/    # Order optimization apps, main user is  MD
├── 11. 영업/         # Sales and store management apps, main user is  sales, CMD
├── 21. 버그 제보_개선 요청/  # Issue management
└── 99. Module/       # Reusable modules shared across apps

queries/              # Shared SQL queries used across apps
├── season_list_with_%200code-f2f42278/
├── get_latest_seasons-c13b268b/
└── ...

docs/                 # Documentation for apps (data flow diagrams, etc.)
```

### App Structure

Each Retool app folder contains:
- `metadata.json` - App configuration and theme settings
- `.positions.json` - UI component positioning data
- `main.rsx` - Main application container
- `header.rsx` - Header component
- `sidebar.rsx` - Sidebar component
- `functions.rsx` - Helper functions (data transformation, aggregation)
- `src/` - Additional components (containers, tables, charts)
- `lib/` - Library files (queries, transformers)

### Shared Queries

Queries in `queries/` are reusable SQL queries with:
- `metadata.json` - Query configuration and resource reference
- `query.rsx` - Query definition
- `lib/*.sql` - Actual SQL code

Common query patterns:
- `season_list_*` - Season/period selection queries
- `style_*_code` - Product style code lookups
- `get_latest_seasons` - Current season determination

### Modules (99. Module/)

Reusable components that can be embedded in multiple apps:
- **리오더 modules** - Reorder simulation and main tables
- **입고현황 modules** - Inventory receiving status
- **시즌기획_리뷰 modules** - Season planning and review components
- **item_detail** - Product detail view
- **revStatTblModule** - Revenue statistics tables
- **storeDetailModule** - Store detail view

Modules follow the same structure as apps but are designed to be imported into other applications.

## Common Patterns

### Data Loading Pattern

Apps typically follow this flow:
1. **User interaction** in sidebar (date/season/brand selection)
2. **Main data loader** (e.g., `get2YearsResult.js`) orchestrates queries
3. **Parallel query execution** using `Promise.all()` for current and previous period data
4. **Data transformation** with JavaScript functions to merge online/offline data
5. **Grouping and aggregation** by category, grade, or store
6. **Display** in tables and charts

### Data Transformation Functions

Common helper functions in `functions.rsx`:
- `groupBySum(arr, groupKeys, sumKeys)` - Group and sum numeric fields
- `pivotData(data, groupKeys, pivotKey, sumKeys)` - Pivot tables
- Data merging functions (e.g., `mergeCurOutSale.js`, `mergePrevOutSale.js`)
- Online warehouse processing (e.g., `processCurrentOnlineWarehouse.js`)

### Common Categories

Apps are organized by function within each brand:
- **01. 인사이트** - Analytics dashboards (Best/Worst items, sales rates, trends)
- **02. 리오더** - Reorder simulation and management
- **03. 아이템맵** - Item mapping and visualization
- **04. 판매 현황** - Sales status tracking
- **05. 입출고현황** - Inventory in/out status
- **06. 시즌기획_리뷰** - Season planning and review
- **70. 설정_관리** - Settings and master data management

## Working with This Repository

### Making Changes to Apps

1. Apps are identified by their folder path (e.g., `apps/11. 영업/01. 영업/매장목표매출/`)
2. UI components are defined in `.rsx` files using JSX-like syntax
3. Data queries are typically in `lib/` folders or referenced from shared `queries/`
4. Helper functions are in `functions.rsx` with preloaded JavaScript in `metadata.json`

### Modifying Queries

1. Shared queries in `queries/` have a UUID-based folder name
2. SQL code is in `lib/*.sql`
3. Query metadata references a resource ID (`resourceName` in `metadata.json`)
4. Changes to shared queries affect all apps using them

### Modules

When multiple apps need the same component:
1. Check `apps/99. Module/` first for existing modules
2. Modules can be imported into apps via Retool's module system
3. Changes to modules propagate to all apps using them

### Git Workflow

- Branch naming: `feature/`, `fix/`, `project/protect-commit-*`
- Recent pattern: "Protecting [App Name]" commits for app preservation
- Main branch is `main` (not master)
- Pull requests are used for merging changes

## Key Business Concepts

- **시즌 (Season)**: Product seasons tracked by season codes (e.g., 2024S, 2024F)
- **이월 (Carryover)**: Products sold after their original season ends
- **판매율 (Sales Rate)**: (Sales quantity / Shipped quantity) × 100
- **리오더 (Reorder)**: Restocking simulation and management
- **복종 (Category)**: Product categories within brands
- **매장 (Store)**: Physical retail locations and online channels
- **출고 (Shipment)**: Products shipped from warehouse to stores/online
- **입고 (Receiving)**: Products received from suppliers

## Theme Configuration

Apps use custom Retool themes:
- Ettoi apps: "Ettoi Branding Color"
- Agabang apps: "Agabang & Company key color" (App Theme ID: 1)
- Disney apps: Brand-specific theme

When creating or modifying apps, ensure the correct theme is referenced in `metadata.json`.
