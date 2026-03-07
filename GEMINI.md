# Gemini CLI Workflow Mandates

This project follows a strict development workflow synchronized with Jira Scrum/Sprint management.

## Git Sprint Workflow
For every new Sprint or set of related tasks:
1. **Branch Creation**: Create a single branch for the active tasks, named with the primary SCRUM keys (e.g., `sprint-X-SCRUM-16-17-18`).
2. **Implementation**: Perform changes within this branch.
3. **Double-Key Commits**: EVERY commit MUST include the relevant SCRUM keys as prefixes (e.g., `SCRUM-16 SCRUM-17 [Message]`) to ensure Jira tracking.
4. **Push & Review**: Push the sprint branch to origin for Baz review.
5. **Finalization (User Signal Only)**: ONLY after the user explicitly says "finished" or "merge":
   - Switch to `development` and merge the sprint branch.
   - Push `development` to remote.
   - Delete the local sprint branch.
   - Delete the remote sprint branch.

## Project Structure
- `backend/`: Python (FastAPI/Firebase) backend.
- `frontend/`: Flutter/Flame application.

## Asset Management
Always register new assets in `frontend/pubspec.yaml` under the appropriate category.
