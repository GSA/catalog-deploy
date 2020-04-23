---
name: Offboard team member
about: Checklist for offboarding a team member from Data.gov
title: "[Offboard] <email>"
---
These tasks are performed by an Admin unless noted as an action for the outgoing team member.

- [ ] Team member should move all Data.gov related documents to team drives
- [ ] Team member should document any work in progress and schedule a hand-off for any remaining tasks
- [ ] Remove team member's access to the [shared Google Drive](https://drive.google.com/drive/folders/0AMRwhrSyJ5R4Uk9PVA)
- [ ] Remove team member from Data.gov GitHub teams
  - [data-gov-admins](https://github.com/orgs/GSA/teams/data-gov-admin/members)
  - [data-gov-support](https://github.com/orgs/GSA/teams/data-gov-support/members)
  - [data-gov-ckan-multi-partners](https://github.com/orgs/GSA/teams/data-gov-ckan-multi-partners)
- [ ] Remove access from [GSA GitHub org](https://github.com/GSA/GitHub-Administration/blob/master/README.md#removing-access-to-the-gsa-organization) (if leaving GSA)
- [ ] Remove team member from [the `gsa-datagov` organization](https://dashboard.fr.cloud.gov/cloud-foundry/2oBn9LBurIXUNpfmtZCQTCHnxUM/organizations/90047c5d-337f-4802-bd48-2149a4265040/users) on cloud.gov
- [ ] Remove team member from [GCP account](https://console.cloud.google.com/iam-admin/iam?project=tts-datagov)
- [ ] Remove team member from AWS OPP account
- [ ] Remove team member from [AWS sandbox access](https://github.com/GSA/datagov-infrastructure-live/tree/master/iam#new-users)
- [ ] Remove team member from [jumpbox operators](https://github.com/GSA/datagov-deploy/blob/develop/ansible/group_vars/all/vault.yml)
- [ ] Remove team member from Data.gov email lists
  - [Data.gov support list](https://groups.google.com/a/gsa.gov/forum/#!forum/datagov)
  - [Data.gov team list](https://groups.google.com/a/gsa.gov/forum/#!forum/datagovhelp)
- [ ] Remove team member from [Data.gov calendar](https://calendar.google.com/calendar/r/settings/calendar/Z3NhLmdvdl9zcjZ0NG52YjRhOTNjNnNzdHRxYXAzbjZtMEBncm91cC5jYWxlbmRhci5nb29nbGUuY29t) and events
- [ ] Remove team member from Uptrends via [email](https://docs.google.com/spreadsheets/d/1Z9Zpr1mpx-65i_fH2VTbVofPtidpLZs5cnkO0Jz53Vc/edit#gid=0)
- [ ] Remove team member from [New Relic](https://newrelic.com)
- [ ] Remove team member from [Docker Hub](https://cloud.docker.com/orgs/datagov/teams)
- [ ] Remove team member from [Data.gov system accounts](https://github.com/GSA/datagov-deploy/wiki/CKAN-commands#system-administrator-accounts) on Inventory and Catalog
- [ ] Remove team member from TTS Bug Bounty access [#bug-bounty-partners](https://gsa-tts.slack.com/messages/C5JQCD9PH)
- [ ] Remove team member from [Snyk](https://app.snyk.io/org/data.gov/manage/members)
- [ ] Remove team member from [Agari](https://gsa-tts.bp.agari.com/) (see [#admins-dmarc](https://gsa-tts.slack.com/archives/CNDTG5ML5) or @adborden for access)
- [ ] [Rotate Ansible Vault key](https://github.com/GSA/datagov-deploy/wiki/Keypair-Rotation#ansible-vault) and [update the canonical location](https://docs.google.com/document/d/1detdsnIuwmqz6asrIfUWrmxCr56MGschY1yV0UeC_24/edit)
