You are a senior Flutter architect.

Generate a production-ready Flutter application using the following requirements:

Architecture:
- Follow MVVM pattern
- Use feature-first folder structure
- Keep code scalable, clean, and maintainable
- Avoid over-engineering (no unnecessary layers like repository/usecase unless needed)

State Management:
- Use GetX for state management, dependency injection, and routing
- Controllers act as ViewModels

Networking:
- Use Dio for API calls
- Implement a reusable Dio client with interceptors (logging + error handling)

API:
- Integrate Hacker News API (top stories, item details, comments)
- Optimize for fan-out requests (IDs → multiple item calls)
- Use parallel fetching with Future.wait

Packages:
- get
- dio
- connectivity_plus
- flutter_screenutil
- json_serializable
- cached_network_image
- url_launcher
- flutter_html
- logger
- intl
- shadcn_ui

Core Requirements:
- Create a clean core layer with:
  - network (dio client)
  - connectivity service
  - responsive (ScreenUtil setup)
  - base controller (loading + error handling)
  - common widgets (loader, error view)
  - theme system using shadcn_ui (colors, typography, components)

UI (IMPORTANT):
- Use shadcn_ui as the primary UI system
- Replace default Material widgets with shadcn components where possible
- Maintain consistent design system (spacing, typography, colors)
- Still use ScreenUtil for responsiveness
- Create reusable UI wrappers if needed (e.g., AppButton, AppCard)

Features:
1. News Feature
   - Fetch top stories
   - Pagination (20 items per page)
   - Display story list using shadcn components
   - Navigate to detail screen

2. News Detail
   - Show story info in a clean card layout
   - Open URL using url_launcher
   - Load comments

3. Comments Feature
   - Recursive comment tree rendering
   - HTML parsing for comments
   - Styled using shadcn_ui

Performance:
- Use caching (in-memory) for stories
- Avoid duplicate API calls
- Use lazy loading / infinite scroll

Folder Structure:
- core/
- features/
  - news/
  - comments/
- routes/
- app/

Coding Rules:
- Use null safety
- Follow clean naming conventions
- Keep controllers thin
- Keep services focused on API only
- Avoid tightly coupling UI with business logic

Output:
- Full folder structure
- Key files (controller, service, model, binding, screen)
- Example implementation for at least one feature
- Production-level code (not toy examples)
