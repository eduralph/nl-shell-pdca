# Act log — nl-shell-pdca

> Append-only, cross-cycle (docs 02 §ACT). Each entry records which frozen
> bundles an Act review considered, what their records exposed, the concrete
> process deltas applied (each located by a path / rule ID / template field), and
> how the next review will judge whether the delta worked. Act never re-decides a
> contribution's disposition. New entries are appended at the end of this file —
> never prepended, never inserted between existing entries.

<!-- Template for a new entry:

# Act review — <date> — cycles considered: <issue_ids>

## What the cycles' records exposed
- <pattern across one or more cycles, citing SUMMARY §6/§7/§10>

## Process deltas
- Spec template: <field added/clarified/removed>            (path)
- Ruleset: <rule added/retired/relaxed/tightened>           (path:line)
- Gates: <check added/promoted/moved>                       (path:line)
- Agent role prompts: <agents/*.md / skill adjustment>      (path:line)

## Follow-ups routed (not process deltas — work handed to an owner)
- Another bug (project/component): filed <tracker> #NNNN    (link)
- Design issue: <name> → dedicated design phase, owner <who>
- Harness/driver issue: this repo's tracker | template feedback upstream  (link)
- Other open Act item: <item> → owner <who>, next step <…>

## How effectiveness will be judged
- The next Do phases should not recreate <specific issue>. Watch the next K cycles.
-->

(no Act reviews yet)

# Act review — 2026-10-15 — cycles considered: issue_7, issue_10, issue_14, issue_15, issue_16, issue_62, issue_77, issue_92, issue_97, issue_98, issue_101, issue_102, issue_140, issue_141, issue_143, issue_144, issue_151, issue_152, issue_155, issue_156

## What the cycles' records exposed
- The T2 security-path gate reported "no security-relevant path touched" on files that decide trust: `targets/*/allowlist.toml` (issue_92 §6), `targets/*/target.toml` (issue_62 §6), `teacher_client.py` and the endpoint selection in `cli.py` (issue_151 §6, issue_152 §10). Reviewers caught each one by hand.
- Briefs pointed Do at artifacts in other bundles by absolute path (`results/issue_7/iteration-v3/patch.diff`, `results/issue_77/…`, `results/issue_101/…`). The plan advisory could not check them. Seen in issue_97, 98, 140, 141, 151 (§6).
- Briefs edited one normative doc and left a sibling doc stating the opposite: issue_101, 102, 140, 141, 152 (§6, plan advisory).
- Success criteria had wall-clock bounds with thin headroom, flagged as flaky: issue_101, 102, 141, 151 (§6).
- Split children had no `notes.json`/`sources/`, so the plan advisory reported "tracker record missing". This hit issue_102, 143, 151, 152, 156, 97, 98 (recurring class, 8×).
- Already owned upstream, so no new delta: T5 prior-art NEEDS-HUMAN on every bundle (pdca-harness#575), size backstop 8× (#719, #556), `Depends on` a PLANNED prereq (#644, #738), unchecked settled decisions (#641). The 6× "confirm the close disposition 'split'" is the intended human confirmation, so no change.

## Process deltas
None were applied in this session. With the human's agreement, each delta was filed as an issue in the repo that owns the file:
- Gates: widen the T2 security path list to `targets/*/*.toml`, `src/nl_shell/*teacher*`, `src/nl_shell/cli.py`, `src/nl_shell/*failure_class*`, `src/nl_shell/render.py`, `src/nl_shell/*charsafety*`   (`engine/scripts/check-threat-model-touch.sh:19-23`, tests `engine/tests/test_threat_model_touch.py`) → https://github.com/eduralph/nl-shell-pdca/issues/23
- Agent role prompts: no cross-bundle absolute paths in a brief; quote the excerpt or copy it into `sources/`   (`agents/planner.md`, `agents/plan-reviewer.md`) → https://github.com/eduralph/pdca-harness/issues/758
- Agent role prompts: a brief that changes normative text must find and edit (or name) every sibling statement of the same rule   (`agents/planner.md`) → https://github.com/eduralph/pdca-harness/issues/759
- Agent role prompts: timing bounds in a criterion need ≥4× headroom or must be labelled test timeouts   (`agents/planner.md`, `agents/plan-reviewer.md`) → https://github.com/eduralph/pdca-harness/issues/760

## Follow-ups routed (not process deltas — work handed to an owner)
- Harness/driver issue (upstream template): split children get no `notes.json`/`sources/` → https://github.com/eduralph/pdca-harness/issues/761
- Another bug (nl-shell): filter mirrored output (OSC 52, concealed text), blocks #78 (issue_10 §10) → https://github.com/eduralph/nl-shell/issues/163
- Another bug (nl-shell): lone 0x9b read as 8-bit CSI resumes alt-screen capture (issue_102 §10) → https://github.com/eduralph/nl-shell/issues/164
- Another bug (nl-shell): `_fds_match` puts a raw file name into the degrade reason (issue_141 §10) → https://github.com/eduralph/nl-shell/issues/165
- Another bug (nl-shell): `test_disabling_any_hook_builtin_degrades` red leg fails on AttributeError (issue_141 §10) → https://github.com/eduralph/nl-shell/issues/166
- Another bug (nl-shell): `HIDDEN` vectors U+E0000 / U+009F (issue_143 §10) → https://github.com/eduralph/nl-shell/issues/167
- Another bug (nl-shell): empty word in `command_provider` (issue_156 §10) → https://github.com/eduralph/nl-shell/issues/168
- Another bug (nl-shell): ADR-0018 §5 vs ADR-0020 §3 (issue_152 §10) → https://github.com/eduralph/nl-shell/issues/169
- Other open Act item: record the mixed-script descope and Unicode 16.0.0 pin on nl-shell #144 (issue_144 §10) → owner: human. Next step: post the comment on #144. Not posted here because the decision text should come from the human.
- Other open Act item: post the 2026-10-21 P1–P5 privilege-rule decision on nl-shell #155 (issue_155 §10) → owner: human. Next step: post the comment on #155.
- Another bug (nl-shell): Ctrl-C during a model request ends the REPL (issue_151 §10, "left for #152"). #152's brief put `repl.py` out of scope, so it was never picked up → https://github.com/eduralph/nl-shell/issues/170
- Another bug (nl-shell): threat model doesn't cover the teacher client / endpoint selection (issue_151 §6 T2, issue_152 §10). Neither patch touched the threat model → https://github.com/eduralph/nl-shell/issues/171
- Added to an existing nl-shell issue: plain `set -a` degrades the session (issue_140 §10, "revisit in #145"). #145 did not list it → https://github.com/eduralph/nl-shell/issues/145#issuecomment-6316414311
- Checked and already tracked: `less +!`/`LESS`/`MANOPT` (issue_92 §6) in nl-shell #139; sudo behind a wrapper (issue_62 §6) in #155; background-job and PTY-reader races (issue_141 §6) in #147 and #148; command substitution and the prompt rule (issue_101 §6) handled by #136's `/proc` rule. Upstream pdca-harness#742 and #743 were already filed (issue_141 §10).
- Process-delta ledger (`process/act-ledger.json`): all 11 signals stay `open`, because no delta was applied in this session. T5 maps to pdca-harness#575, the size backstop to #719/#556, "no tracker record" to #761. Mark each with `resolve` once its fix lands.

## How effectiveness will be judged
- After nl-shell-pdca#23 lands, the next cycle that touches `targets/` or the teacher client should show T2 as UNVERIFIABLE (or EVIDENCE), not "no security-relevant path touched".
- After #758–#760 land upstream and are re-rendered, watch the next 5 plan advisories. There should be no findings about cross-bundle paths, contradicting sibling docs, or flaky timing bounds.
- After #761, the "No tracker record to check the brief against" class should drop to 0 for split children.

# Act review — 2026-10-26 — cycles considered: issue_61, issue_108, issue_120, issue_196, issue_197

## What the cycles' records exposed
- Every recurring class in these cycles was already owned after the 2026-10-15 review. None of those fixes has landed, so these cycles show the problems still happen. They can't yet show whether the deltas work:
  - T5 prior-art NEEDS-HUMAN (issue_61, 108, 120, 196) → pdca-harness#575
  - size backstop (issue_61, 108, 120) → #719, #556
  - split child with no tracker record (issue_61, 196 §6) → #761
  - brief cites files outside the bundle: `results/issue_196/iteration-v*`, `results/issue_189/…`, `engine/scripts/run-verify.sh` (issue_196 §6) → #758
  - wall-clock criterion "classify in under 1 s" (issue_196 §6) → #760
  - a ruling or brief that contradicts a sibling spec: Rule 1 vs policy-gate §1.2 (issue_196), plus issue_120 → #759
  - T2 flagged the threat model as not updated (issue_196). The gate worked as intended.
- issue_196 took 8 rounds, because each review found a new place where tree-sitter-bash and real bash disagree (§10). This was seen in one cycle only, and the differential parser test it asks for is already a planned slice (nl-shell#191). So it is recorded as an open item, not a delta.
- issue_197 closed as a split (children #204–#206). The 7× "confirm the close disposition 'split'" stays the intended human confirmation.

## Process deltas
No delta warranted. Each recurring class maps to an open upstream issue (above) or to nl-shell-pdca#23. Adding deltas before those land would be forcing it.

## Follow-ups routed (not process deltas — work handed to an owner)
Before filing, each §10 follow-up was checked against nl-shell `main` (1a1e980), running the gate inputs through `classify` / `shell_layer`. Parts already fixed were left out.
- Another bug (nl-shell): `run()` calls `_stop_background()` before the `try` (`session.py:939`). A Ctrl-C there leaves no reader and leaks the wake pipe (issue_120 §10) → https://github.com/getwyrd/nl-shell/issues/209
- Another bug (nl-shell): `forkpty()` runs a Python `preexec_fn` (`session.py:736`) while a reader thread is alive. Should land before #78 (issue_120 §10) → https://github.com/getwyrd/nl-shell/issues/210
- Another bug (nl-shell): `diagnose` lets exceptions from the injected lookups escape (issue_61 §10). The `_exists` half is already fixed on `main` (`reader.py:322-326`) → https://github.com/getwyrd/nl-shell/issues/211
- Another bug (nl-shell): wrong stdin/prefix facts for `PATH=… $(true)`, `coproc`, and `</dev/stdin` (issue_196 §10). The `trap` part is already fixed (`parse.py:1177`) → https://github.com/getwyrd/nl-shell/issues/212
- Another bug (nl-shell, security): nested backticks and backticks in an unquoted here-doc hide commands and fd-3 redirects (issue_196 §10). Already fixed, so not filed: quoted `export 'SUDO_PROMPT=x'`, fd 3 via `~/3` or `cd /dev/fd`, `[ x > f ]`, non-literal redirect targets → https://github.com/getwyrd/nl-shell/issues/213
- Checked and already tracked: "English that still reaches the shell" (issue_108 §10) is nl-shell#40.
- Other open Act item: router test gaps, where rule 4's `.lower()` is untested and 16 of 18 `SHELL_METACHARACTERS` aren't pinned (issue_108 §10). Not filed, because #40 replaces the router. Owner: human. Next step: decide whether to file it or drop it.
- Other open Act item: record the proposal-rejection ruling (Rule 1 vs policy-gate §1.2) on nl-shell#196 or as a spec edit (issue_196 §10). Owner: human, since the ruling text should be the human's.
- Other open Act item: nl-shell#198 says "Depends on: child-1, child-2". Since #197 split into #204–#206, that label is ambiguous. Point it at #204 (issue_197 §10). Owner: human.
- Other open Act item: build nl-shell#191 (the differential parser test) before #204–#206? A scheduling call (issue_196 §10). Owner: human. At the next review, check how many rounds #204–#206 needed. If it was many again, consider a planner delta: a slice whose correctness means "agrees with bash" names a differential test in its success criterion.
- Carried over from 2026-10-15, still open: the comments for nl-shell#144 (mixed-script descope, Unicode 16.0.0 pin) and #155 (2026-10-21 P1–P5 decision) haven't been posted. Owner: human.

## How effectiveness will be judged
- The 2026-10-15 criteria still apply, unchanged. Judge them once nl-shell-pdca#23 and pdca-harness#758–#761 land and are re-rendered.
- The next review should find #209–#213 closed or scheduled, and should not see these defects again in the gate children (#204–#206).
