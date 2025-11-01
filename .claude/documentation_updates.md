# Documentation Updates Protocol

## Keep Implementation Plan Updated

When working on tasks in this project, **always update** [docs/IMPLEMENTATION_PLAN.md](../docs/IMPLEMENTATION_PLAN.md) with checkmarks as you complete tasks.

### Guidelines

1. **Mark tasks complete immediately** when finished:
   - Change `- [ ] Task name` to `- [x] Task name`
   - Update the milestone header if all tasks are complete

2. **Update milestone status**:
   - When starting a milestone: Note which tasks are in progress
   - When completing a milestone: Mark the milestone header with ✅
   - Example: `## M1: Authentication & Core UI (Week 2) ✅`

3. **Keep docs in sync**:
   - When completing milestones, also check if [docs/DESIGN.md](../docs/DESIGN.md) needs updates
   - If features are implemented differently than planned, document the changes
   - Update [docs/SCHEMA.md](../docs/SCHEMA.md) if database structure changes

4. **Git commits and pushes**:
   - After completing significant milestones, commit the updated documentation
   - Include doc updates in the same commit as the feature implementation
   - Example commit: "Complete M1: Auth & UI + update docs"
   - Git commit and git push operations can be performed automatically
   - Push to remote after milestone completion to keep remote in sync

### Why This Matters

- Provides clear progress tracking at a glance
- Helps team members understand what's been completed
- Creates a reliable historical record of development
- Makes it easy to pick up where you left off

### Quick Reference

- Implementation plan: [docs/IMPLEMENTATION_PLAN.md](../docs/IMPLEMENTATION_PLAN.md)
- Database schema: [docs/SCHEMA.md](../docs/SCHEMA.md)
- Design document: [docs/DESIGN.md](../docs/DESIGN.md)
- Business plan: [docs/BUSINESS_PLAN.md](../docs/BUSINESS_PLAN.md)
