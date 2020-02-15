# Minerva :: Daily Journal

Minerva is a journaling application that enables people to keep track of the curious, interesting
and shocking moments of their lives by adding a note about each event in their journal.

## Assignment
Build a Rails prototype of the Minerva web-application. The goal of the prototype is a focus on
the core journalling functionality. We aren’t concerned about user permissions and management
(at least for now).

## Core Scenarios

#### Journal and Journal Entries
There are two main concepts in this app, journals and journal entries. Each journal has a name
and can have multiple journal entries. Each journal entry has a title, body, a timestamp for when
the journal was written and a timestamp for when the journal was edited.
The prototype requirements are:
- User should be able to create a new journal
- Journal’s should have a name
- User should be able to see a list of the journals
- For each journal, a user should see a list of journal entries grouped by date
- List of journal entries should have title, an indicator if the journal has been edited
and a link the full details of the journal entry

- User should be able to add a new journal entry for this specific journal the page with all
the journal entries.
- User should be able to search journals by title --
- Journal entries should have title and body fields
- When a journal entry is created, it’s journal date and time should be set automatically.
- User should be able to edit journal entries

#### Bonus
There should a journal visual. This is a bar chart on the journal page that provides insight into
journal entry frequency.
Journal visual requirements are:
- By default, visual should be based on all journal entries in the journal. If the user has
searched for journal entries based on title, the visual should be scoped by the results.
- The chart should have a dropdown for: last week, last month, last year and all
- If last week or last month is selected
- The x-axis of the chart should be days and the y-axis should be # of posts
for each day
- If last year or all is selected
- The x-axis of the chart should be months and the y-axis should be # of
post for each month

User Authentication
- For this prototype, none... no login required.
