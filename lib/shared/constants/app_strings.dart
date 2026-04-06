// LAYER: Shared / Constants
// PURPOSE: All user-visible strings in one place for easy localisation later.
//          Never hardcode strings in screens.

abstract class AppStrings {
  // ─── App ──────────────────────────────────────────────────────────────────
  static const appName = 'LifeCoach AI';
  static const appTagline = 'Your AI-powered life coach';

  // ─── Onboarding ───────────────────────────────────────────────────────────
  static const onboardingNext = 'Next';
  static const onboardingGetStarted = 'Get Started';
  static const onboardingSkip = 'Skip';

  // Page 1
  static const ob1Title = 'Track Your Daily Habits';
  static const ob1Body =
      'Build powerful routines with streaks, reminders, and a daily score that keeps you motivated.';

  // Page 2
  static const ob2Title = 'Monitor Your Health';
  static const ob2Body =
      'Log water, sleep, mood, and steps in seconds. See your weekly trends at a glance.';

  // Page 3
  static const ob3Title = 'Master Your Finances';
  static const ob3Body =
      'Track expenses by category, set budgets, and get alerts before you overspend.';

  // Page 4
  static const ob4Title = 'Meet Your AI Coach';
  static const ob4Body =
      'Get personalised advice from Claude AI — powered by your real health, habit, and finance data.';

  // ─── Auth ─────────────────────────────────────────────────────────────────
  static const signIn = 'Sign In';
  static const signUp = 'Create Account';
  static const signOut = 'Sign Out';
  static const email = 'Email';
  static const password = 'Password';
  static const continueGoogle = 'Continue with Google';

  // ─── Dashboard ────────────────────────────────────────────────────────────
  static const dailyScore = 'Daily Life Score';
  static const goodMorning = 'Good morning';
  static const goodAfternoon = 'Good afternoon';
  static const goodEvening = 'Good evening';

  // ─── Habits ───────────────────────────────────────────────────────────────
  static const habits = 'Habits';
  static const addHabit = 'Add Habit';
  static const streak = 'day streak';

  // ─── Health ───────────────────────────────────────────────────────────────
  static const health = 'Health';
  static const water = 'Water';
  static const sleep = 'Sleep';
  static const mood = 'Mood';
  static const steps = 'Steps';

  // ─── Finance ──────────────────────────────────────────────────────────────
  static const finance = 'Finance';
  static const addExpense = 'Add Expense';
  static const budget = 'Budget';
  static const budgetAlert = 'You\'ve used 80% of your budget';

  // ─── Goals ────────────────────────────────────────────────────────────────
  static const goals = 'Goals';
  static const addGoal = 'Add Goal';
  static const milestones = 'Milestones';

  // ─── Planner ──────────────────────────────────────────────────────────────
  static const planner = 'Planner';
  static const addTask = 'Add Task';

  // ─── AI Coach ─────────────────────────────────────────────────────────────
  static const aiCoach = 'AI Coach';
  static const typeMessage = 'Ask your coach…';
  static const rateLimitMsg =
      'You\'ve reached your daily coaching limit (20 messages)';
  static const coachUnavailable = 'Coach is unavailable, please try again';

  // ─── General ──────────────────────────────────────────────────────────────
  static const save = 'Save';
  static const cancel = 'Cancel';
  static const delete = 'Delete';
  static const confirm = 'Confirm';
  static const loading = 'Loading…';
  static const retry = 'Retry';
  static const noData = 'Nothing here yet';
}
