import 'package:binary_city/features/clients/form/presentation/bloc/add_client_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets/app_secrets.dart';
import 'features/clients/form/data/datasources/add_client_remote_datasource.dart';
import 'features/clients/form/data/repository/add_client_repo_impl.dart';
import 'features/clients/form/domain/repository/add_client_repo.dart';
import 'features/clients/form/domain/usecases/add_client.dart';
import 'features/clients/view/data/datasources/client_view_remote_datasource.dart';
import 'features/clients/view/data/repository/client_view_repo_impl.dart';
import 'features/clients/view/domain/repository/client_view_repo.dart';
import 'features/clients/view/domain/usecases/get_clients.dart';
import 'features/clients/view/presentation/bloc/client_view_bloc.dart';
import 'features/contacts/form/data/datasources/contact_form_remote_datasource.dart';
import 'features/contacts/form/data/repository/contact_form_repo_impl.dart';
import 'features/contacts/form/domain/repository/contact_form_repo.dart';
import 'features/contacts/form/domain/usecases/create_contact.dart';
import 'features/contacts/form/presentation/bloc/create_form_bloc.dart';

part 'init_dependencies.main.dart';
