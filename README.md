# FoodPrint Mobile

**FoodPrint** is a food waste reporting and data platform. Citizens report the food waste they find around them. Officials claim and clear those reports. Organizations and local governments use the collected data to plan their actions. The app also teaches people how to sort and reduce food waste.

This repository holds the Flutter mobile app. It talks to the existing FoodPrint Django website through a REST API built with Django REST Framework (DRF).

- Website: https://delitha-theodora-foodprint.pws.cs.ui.ac.id
- Django repository: https://github.com/PBP-Group-KKI2/foodprint

---

## Team Members and Modules

| Name | Student ID | Module |
| :--- | :--- | :--- |
| Muhammad Arsyad Avmeilputra | 2506556246 | Analytics & Dashboards |
| Dihya Fauzan Haryadi | 2506637003 | Profile |
| Kenaz Shidqi Baswara | 2506558144 | Reward System |
| Delitha Theodora | 2506553585 | Educational Hub |
| Goran Adriano Tamrella | 2506558251 | Reporting & Mapping |
| Sorush Baghertash | 2606816434 | Task Dispatch |

### Module Scope

| Module | Mobile page | What it covers |
| :--- | :--- | :--- |
| Reporting & Mapping | Waste Reports | Lists waste reports with their type, severity, status and location. Create, edit and delete are available in the API. |
| Profile | Profile | Shows the signed-in user's username, role, email, points and rank. The email and rank visibility can be updated. |
| Reward System | Rewards | Shows points, current rank, the next rank, the points still needed, and the points earned per report. Rank visibility can be toggled. |
| Educational Hub | Educational Hub | Lists articles with category, excerpt, author, likes, comments and views. Articles can be created, edited, deleted, liked, saved and commented on. |
| Analytics & Dashboards | Analytics | Shows total and resolved reports, broken down by waste type, severity and city. Users can save their own filter presets. |
| Task Dispatch | Task Dispatch | Lets officials see unclaimed reports, then claim, update, close or release collection tasks. |

## User Roles

| Role | Can do |
| :--- | :--- |
| Visitor (not signed in) | Browse waste reports, articles, comments and the analytics summary. |
| Citizen (`USERS`) | Everything a visitor can do. They can also post reports to earn points, manage their profile and rewards, write, like, save and comment on articles, and save analytics presets. |
| Organization (`ORGANIZATION`) | Same as a citizen. The analytics data and presets support their campaigns. |
| Official / Government (`OFFICIAL`) | Same as a citizen. They can also claim, update, close and release collection tasks. |
| Administrator (staff) | Manages content and users. Staff accounts can moderate any report or article and can also dispatch tasks. |

---

## Integration with the Django Web Service

The Django project now has a REST API under `/api/v1/`. It is built with Django REST Framework, following Tutorial 07. Each Django app has these files:

- `serializers.py`: ModelSerializers that turn models into JSON. They validate input with the same rules as the website's forms.
- `api_views.py`: function views using `@api_view`, `@authentication_classes([SessionAuthentication])` and `@permission_classes`. Object-level checks reuse the website's own rules: only the owner or staff can edit a report or article, and only officials can dispatch tasks.
- `api_urls.py`: routes included from `foodprint/urls.py`.
- `tests_api.py`: `APITestCase` tests for permissions, validation, and the success and error responses.

### Data flow in the app

1. A page starts a `Future` from `ApiService` (`lib/services/api_service.dart`) in `initState`.
2. `ApiService` sends an HTTP `GET` to the Django API with the `http` package.
   - A non-200 response becomes an `ApiException` that carries the status code and the server's `detail` message.
3. The JSON is converted into a model class through its `fromJson` factory (`lib/models/`).
4. A `FutureBuilder` shows one of these states:
   - a loading state;
   - an error state with a retry button, or a "Sign in required" state for `401`/`403`;
   - an empty state;
   - the data itself.

### Endpoints

| Module | Method and path | Access |
| :--- | :--- | :--- |
| Reporting & Mapping | `GET, POST /api/v1/reports/` | Anyone can read. Only signed-in users can create. |
| | `GET, PUT, PATCH, DELETE /api/v1/reports/<id>/` | Anyone can read. Only the owner or staff can change. |
| Profile | `GET, PATCH /api/v1/profile/` | Signed in |
| Reward System | `GET /api/v1/rewards/` | Signed in |
| | `POST /api/v1/rewards/toggle-rank/` | Signed in |
| Educational Hub | `GET, POST /api/v1/learn/articles/` (`?q=`, `?category=`) | Anyone can read. Only signed-in users can create. |
| | `GET, PUT, PATCH, DELETE /api/v1/learn/articles/<id>/` | Anyone can read. Only the author or staff can change. |
| | `POST /api/v1/learn/articles/<id>/like/` | Signed in |
| | `POST /api/v1/learn/articles/<id>/favorite/` | Signed in |
| | `GET, POST /api/v1/learn/articles/<id>/comments/` | Anyone can read. Only signed-in users can comment. |
| Analytics & Dashboards | `GET /api/v1/analytics/summary/` (`?preset=`) | Anyone |
| | `GET, POST /api/v1/analytics/presets/` | Signed in, own presets only |
| | `GET, PUT, PATCH, DELETE /api/v1/analytics/presets/<id>/` | Signed in, own presets only |
| Task Dispatch | `GET /api/v1/tasks/pending/` | Officials and staff |
| | `GET /api/v1/tasks/` (`?show=closed`) | Officials and staff |
| | `POST /api/v1/tasks/claim/<report_id>/` | Officials and staff |
| | `GET, PATCH /api/v1/tasks/<id>/` | The task's official or staff |
| | `POST /api/v1/tasks/<id>/close/` | The task's official or staff |
| | `POST /api/v1/tasks/<id>/release/` | The task's official or staff |

The browsable API is available in a web browser at `/api/v1/...`. You can sign in to it through `/api-auth/login/`.

### Current limitations

- Signing in from the mobile app is not built yet. The Profile, Rewards and Task Dispatch pages therefore show a "Sign in required" message. Visitor pages (Waste Reports, Educational Hub, Analytics) already show live data.
- The pages are read-only for now. The create, edit and delete endpoints exist and are tested on the Django side, but their forms will be added in later milestones.

---

## Running the App

Start the Django server first:

```bash
cd foodprint            # the Django repository
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

Then run the Flutter app. The API address is set at build time with `API_BASE_URL`. The default is `http://localhost:8000`.

```bash
flutter pub get

# Chrome (uses the default http://localhost:8000)
flutter run -d chrome

# Android emulator (10.0.2.2 is the host machine as seen from the emulator)
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000

# Against the deployed website
flutter run --dart-define=API_BASE_URL=https://delitha-theodora-foodprint.pws.cs.ui.ac.id
```

Run the checks:

```bash
flutter analyze
flutter test
```

---

## Links

- **Figma (mobile design):** _to be added_
  - Website design system: https://www.figma.com/design/YhBHWR2GkBsFA9nxRpUpa3/Design-System-%7C-FoodPrint?m=auto&t=FHjPyd1u4x7syHwU-1
- **APK download:** _to be added_
