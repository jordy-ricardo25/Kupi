// *********************************************************
// DOMAIN
// *********************************************************
export 'domain/entities/auth_state.dart';
export 'domain/entities/auth_user.dart';

export 'domain/repos/auth_notifier.dart';
export 'domain/repos/auth_repository.dart';

// *********************************************************
// DATA
// *********************************************************
export 'data/models/auth_user_model.dart';

export 'data/repos/supabase_auth_notifier.dart';
export 'data/repos/supabase_auth_repository.dart';

// *********************************************************
// PRESENTATION
// *********************************************************
export 'presentation/controller/reset_password_controller.dart';
export 'presentation/controller/sign_in_controller.dart';
export 'presentation/controller/sign_up_controller.dart';
export 'presentation/controller/update_password_controller.dart';

export 'presentation/providers/controller_provider.dart';
export 'presentation/providers/mutation_provider.dart';
export 'presentation/providers/notifier_provider.dart';
export 'presentation/providers/repository_provider.dart';

// export 'presentation/views/reset_password_page.dart';
// export 'presentation/views/sign_in_page.dart';
// export 'presentation/views/sign_up_page.dart';
// export 'presentation/views/update_password_page.dart';

export 'presentation/widgets/auth_card.dart';
export 'presentation/widgets/email_form_field.dart';
export 'presentation/widgets/logout_button.dart';
export 'presentation/widgets/name_form_field.dart';
export 'presentation/widgets/password_form_field.dart';
