# ChatGPT / OpenAI Handoff

## Project
Bassam Faraj founder launch and billing workflow.

## Current State
- `TeamExportView.swift` provides a SwiftUI form for client profile entry, time-entry invoice generation, HTML/PDF export, sharing invoices, and launch-kit generation.
- `Billing.swift` defines client profiles, time entries, invoice line items, invoice aggregation, Markdown invoice generation, HTML export, and simple PDF export.
- `SwiftBaseExample.swift` defines founder launch documents, profile briefs, the Bassam In Reality roadmap, and the launch-kit generator.
- `DocumentBranding.swift` defines founder and Phoenix Hovan brand styles.

## Generated Launch Assets
The launch-kit generator writes:
- `Bassam_Launch_Profile_Pages.rtf` for Pages.
- `Bassam_Revenue_Model_Numbers.csv` for Numbers.
- `Bassam_Keynote_Launch_Outline.md` for Keynote deck creation.
- `Bassam_Get_Paid_Runbook.md` for billing operations.
- `Bassam_In_Reality_Roadmap.csv` for the AI, AR, and Metal roadmap.

## Safety Boundary
This project intentionally avoids reading Mail, Passwords, Keychain, browser sessions, hidden account stores, or broad system folders. Use only explicit client data entered into the app and project files intentionally added by the user.

## Suggested Next OpenAI Task
Review this project as a launch and billing assistant. Help refine the offer, improve the invoice workflow, and turn the Keynote outline into a polished launch deck while preserving the privacy boundary above.
