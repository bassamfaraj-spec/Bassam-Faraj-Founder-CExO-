# Product Lineup

Date: 2026-08-23
Owner: Bassam Faraj
Status: Draft

## Positioning

This lineup turns the phone/security incident response into lawful defensive products, training, and services. The products should help people protect accounts, preserve evidence, recover from SIM/eSIM problems, and understand emergency-calling limits. They should not claim to control carriers, cities, towers, public officials, banks, or law enforcement.

## Product Families

| ID | Product | Customer | Problem | Output | Build Status |
|---|---|---|---|---|---|
| PSC-002 | BassamDM Personal Security Dashboard | Individuals, founders, high-risk users | Device/account risk is scattered across phone, Mac, carrier, cloud, and banking settings. | Local dashboard reading CSV/Markdown registers without storing passwords. | Draft spec exists |
| PSC-003 | Carrier Account Lock Auditor | Mobile customers, support advocates, small businesses | SIM swap, eSIM activation, and port-out fraud can move a number without physical phone theft. | Checklist, carrier call script, support ticket register, fraud evidence packet. | New draft |
| PSC-004 | eSIM Transition Training Kit | Consumers, staff, community trainers | Users confuse disappearing physical SIM trays with account compromise. | Training deck, glossary, device model notes, carrier setup worksheet. | New draft |
| PSC-005 | Emergency Calling Resilience Pack | Families, founders, travelers, vulnerable users | A phone outage or account block can leave a person without a reliable 911 path. | Backup calling plan, wallet card, location-first script, trusted-contact checklist. | New draft |
| PSC-006 | Evidence Packet Builder | Incident victims, attorneys, support teams | Cyber/account claims often fail because facts are not time-stamped and indexed. | Timeline, evidence index, complaint tracker, export bundle. | New draft |
| PSC-007 | Telecom Security Training | Carrier support teams, small businesses, civic groups | Customer-service workflows can be weak against social engineering and account takeover. | Fact-based training modules for authentication, CPNI, SIM fraud, and escalation. | New draft |
| PSC-008 | Founder Recovery Launch Kit | Bassam Faraj operating system | Product, legal, security, and finance work need one launch workflow. | Combined deck outline, service catalog, pricing plan, and ChatGPT handoff. | New draft |

## Release Order

| Phase | Release | Reason |
|---|---|---|
| 1 | Emergency Calling Resilience Pack | Highest safety value and smallest build scope. |
| 2 | Carrier Account Lock Auditor | Directly addresses SIM/eSIM and number-protection concerns. |
| 3 | Evidence Packet Builder | Creates the proof structure needed for legal, carrier, bank, and regulator escalation. |
| 4 | eSIM Transition Training Kit | Converts verified industry facts into public education. |
| 5 | BassamDM Personal Security Dashboard | Requires app work, but existing spec already supports it. |
| 6 | Telecom Security Training | Requires polished curriculum and careful legal review. |
| 7 | Founder Recovery Launch Kit | Packages the full operating system for sales and investor review. |

## Minimum Sellable Offers

| Offer | Price Placeholder | Included |
|---|---:|---|
| Personal Phone Security Check | 0 to 99 | Carrier lock checklist, iPhone/Mac checklist, emergency calling plan. |
| Evidence Packet Setup | 99 to 499 | Timeline template, evidence index, complaint tracker, support-call script. |
| Small Business Mobile Account Hardening | 499 to 2500 | Staff training, carrier lock policy, MFA upgrade plan, incident playbook. |
| Telecom Security Training License | TBD | Training deck, quizzes, facilitator notes, update log. |
| BassamDM App | TBD | Local dashboard for device, app, account, incident, and release registers. |

## Fact-Based Training Modules

| Module | Outcome |
|---|---|
| SIM, eSIM, and porting basics | Learner can explain physical SIM, eSIM, number porting, SIM swap fraud, and normal eSIM-only device behavior. |
| Emergency calling readiness | Learner can build a backup emergency-call plan and understand 911 limitations on inactive phones. |
| Carrier account hardening | Learner can request SIM locks, port locks, account PINs, fraud flags, and written support case IDs. |
| Personal device hardening | Learner can check iOS, macOS, profiles, VPN, sharing, browser extensions, backups, and Lockdown Mode. |
| Account authentication | Learner can explain why security keys and authenticator apps are stronger than SMS-only recovery. |
| Evidence and escalation | Learner can collect a timeline, source files, support IDs, complaint IDs, and verification status. |
| Lawful reporting | Learner can route issues to carriers, banks, FCC, FTC, FBI IC3, police, or counsel without overstating facts. |

## Product Rules

1. Do not store passwords, private keys, recovery codes, banking credentials, or raw secrets.
2. Separate personal claims from verified facts.
3. Use official sources for industry and regulatory statements.
4. Require user confirmation before destructive or account-changing actions.
5. Treat telecom, bank, city, and federal allegations as evidence-required until proven.
6. Make emergency readiness the first deliverable.
7. Make exports attorney-ready, but do not label them legal filings unless counsel approves.

## Next Build Tasks

| Task | File Or Asset | Status |
|---|---|---|
| Add product rows to Product_Service_Catalog.csv | 04_Finance_Hub/Product_Service_Catalog.csv | Done |
| Build Evidence_Index_Template columns for phone/carrier evidence | 03_IP_Legal/Faraj_Legal_App/Evidence_Index_Template.csv | Pending |
| Create one-page emergency wallet card | 11_HovanOS_BassamDM/Security_Audit | Pending |
| Create training deck outline | 08_Content_Civil_Service or 10_Export_Ready | Pending |
| Convert BassamDM spec into SwiftUI MVP tasks | 12_Reality_State_System/BassamDM_App_Product_Spec.md | Pending |

## Owner Review

Owner reviewed by: ______________________________

Date: ______________________________
